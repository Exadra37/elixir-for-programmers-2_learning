ARG ELIXIR_VERSION
ARG OTP_VERSION
ARG ALPINE_VERSION

# FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION} as build
FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION} as build

ARG MIX_ENV=prod
ARG BUILD_RELEASE_FROM=master
ARG GIT_CLONE_URL=https://gitlab.com/exadra37-playground/elixir/video-hub.git
ARG GIT_USER_DEPLOY_TOKEN
ENV GIT_USER_DEPLOY_TOKEN=${GIT_USER_DEPLOY_TOKEN}

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

COPY .env /release/.env
COPY ./.git /workspace

RUN \
  git clone --local /workspace . && \
  git checkout "${BUILD_RELEASE_FROM}" && \
  ls -al

RUN \
  # @link https://github.com/elixir-lang/elixir/issues/3422#issuecomment-388188608
  # @link https://gist.github.com/Kovrinic/ea5e7123ab5c97d451804ea222ecd78a
  git config --global url."https://exadra37:${GIT_USER_DEPLOY_TOKEN}@gitlab.com".insteadOf https://gitlab.com  && \

  cd hangman/hangman_live && \
  ls -al && \

  mix local.hex --force && \
  mix local.rebar --force && \

  mix deps.get --only "${MIX_ENV}" && \

  mix compile && \

  mix assets.deploy && \

  mix phx.gen.release && \

  mix release

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

COPY --from=build --chown="${USER}":"${USER}" /app/hangman/hangman_live/_build/prod/rel/hangman_live ./

RUN ls -al bin/

# ENTRYPOINT ["./bin"]

# Docker Usage:
#  * build: sudo docker build -t phoenix/hangman_live .
#  * shell: sudo docker run --rm -it --entrypoint "" -p 80:4000 -p 443:4040 phoenix/hangman_live sh
#  * run:   sudo docker run --rm -it -p 80:4000 -p 443:4040 --env-file .env --name hangman_live phoenix/hangman_live
#  * exec:  sudo docker exec -it hangman_live sh
#  * logs:  sudo docker logs --follow --tail 10 hangman_live
#
# Extract the production release to your host machine with:
#
# ```
# sudo docker run --rm -it --entrypoint "" --user $(id -u) -v "$PWD/_build:/home/phoenix/_build"  phoenix/hangman_live sh -c "tar zcf /home/phoenix/_build/app.tar.gz ."
# ls -al _build
# ````
CMD ["./bin/server"]
