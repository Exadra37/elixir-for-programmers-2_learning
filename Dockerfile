ARG ELIXIR_VERSION
ARG OTP_VERSION
ARG ALPINE_VERSION

FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION} AS build

ARG MIX_ENV=prod
ARG BUILD_RELEASE_FROM=main
ARG GIT_CLONE_URL=https://github.com/Exadra37/elixir-phoenix-hangman.git

ENV RELEASE_PATH="${CONTAINER_HOME}"/phoenix_release
ENV MIX_ENV=${MIX_ENV}

WORKDIR /app

RUN \
  apk add \
    --no-cache \
    openssh-client \
    build-base \
    libstdc++6 \
    npm \
    git \
    python3

ENV USER="phoenix"
ENV HOME=/home/"${USER}"
ENV APP_DIR="${HOME}/app"

RUN \
  addgroup \
   -g 1000 \
   -S "${USER}" && \
  adduser \
   -s /bin/sh \
   -u 1000 \
   -G "${USER}" \
   -h "${HOME}" \
   -D "${USER}" && \

  su "${USER}" sh -c "mkdir ${APP_DIR}"

# Everything from this line onwards will run in the context of the unprivileged user.
USER "${USER}"

WORKDIR "${APP_DIR}"

COPY --chown="${USER}":"${USER}" .env /release/.env
COPY --chown="${USER}":"${USER}" ./.git "${HOME}"/workspace

RUN git clone --depth 1 --branch ${BUILD_RELEASE_FROM} ${GIT_CLONE_URL} .

WORKDIR "${APP_DIR}/hangman/hangman_live"

RUN mix local.hex --force && \
  mix local.rebar --force

RUN pwd
RUN ls -al

RUN mix deps.get --only "${MIX_ENV}"

RUN mix compile

RUN mix assets.deploy

RUN mix phx.gen.release

RUN mix release

# Start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM alpine:${ALPINE_VERSION} AS app

RUN apk add --no-cache openssl ncurses-libs libstdc++

ENV USER="phoenix"
ENV HOME=/home/"${USER}"
ENV APP_DIR="${HOME}/app"

# Creates a unprivileged user to run the app
RUN \
  addgroup \
   -g 1000 \
   -S "${USER}" && \
  adduser \
   -s /bin/sh \
   -u 1000 \
   -G "${USER}" \
   -h "${HOME}" \
   -D "${USER}" && \

  su "${USER}" sh -c "mkdir ${APP_DIR}"

# Everything from this line onwards will run in the context of the unprivileged user.
USER "${USER}"

WORKDIR "${APP_DIR}"

COPY --from=build --chown="${USER}":"${USER}" "${APP_DIR}"/hangman/hangman_live/_build/prod/rel/hangman_live ./

RUN ls -al bin/

ENV PHX_SERVER=true

ENTRYPOINT ["./bin/hangman_live"]

CMD ["start"]
