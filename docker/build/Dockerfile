ARG ELIXIR_VERSION
ARG OTP_VERSION
ARG ALPINE_VERSION

FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION} as build

ARG MIX_ENV=dev

ENV MIX_ENV=${MIX_ENV}

ENV USER="developer"
ENV HOME=/home/"${USER}"
ENV APP_DIR="${HOME}/workspace"

RUN \
  apk add \
    --no-cache \
    openssh-client \
    build-base \
    npm \
    git && \

# Creates a unprivileged user to run the app
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

RUN \
  mix local.hex --force && \
  mix local.rebar --force

ARG GIT_USER_DEPLOY_TOKEN

RUN \
  # @link https://github.com/elixir-lang/elixir/issues/3422#issuecomment-388188608
  # @link https://gist.github.com/Kovrinic/ea5e7123ab5c97d451804ea222ecd78a
  git config --global url."https://exadra37:${GIT_USER_DEPLOY_TOKEN}@gitlab.com".insteadOf git://gitlab.com

WORKDIR "${APP_DIR}"

CMD ["sh"]
