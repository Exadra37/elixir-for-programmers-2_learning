#!/bin/sh

set -eu

SSH_Remote_Execute() {
  ssh \
    -p "${REMOTE_PORT}" \
    "${REMOTE_USER}"@"${REMOTE_ADDRESS}" "${1? Missing command to execute via SSH on the remote server...}"
}

SCP_Copy_To_Remote() {
  scp \
    -P "${REMOTE_PORT}" \
    "${1? Missing the file to copy with SCP to the remote server...}" \
    "${REMOTE_USER}"@"${REMOTE_ADDRESS}":"${REMOTE_APP_DIR}"
}

Docker_Build_Release() {
    # --no-cache \
    # --build-arg "SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa)" \
    # --build-arg "SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)" \
  sudo docker build \
    --build-arg "GIT_USER_DEPLOY_TOKEN=${GIT_USER_DEPLOY_TOKEN}" \
    --build-arg "ELIXIR_VERSION=${ELIXIR_VERSION? Missing value for ELIXIR_VERSION}" \
    --build-arg "OTP_VERSION=${ERLANG_OTP_VERSION? Missing value for ERLANG_OTP_VERSION}" \
    --build-arg "ALPINE_VERSION=${ALPINE_VERSION? Missing value for ALPINE_VERSION}" \
    --build-arg "BUILD_RELEASE_FROM=${BUILD_RELEASE_FROM? Missing value for BUILD_RELEASE_FROM}" \
    --tag "${DOCKER_IMAGE}" \
    "${PWD}"
}

SSH_Remote_Docker_Load() {
  printf "\n---> Loading the docker image ${DOCKER_IMAGE} to ${REMOTE_USER}@${REMOTE_ADDRESS}:${REMOTE_PORT}\n"

  sudo docker \
    save "${DOCKER_IMAGE}" | gzip -6 | \
    ssh -p "${REMOTE_PORT}" "${REMOTE_USER}"@"${REMOTE_ADDRESS}" "gzip -d | docker load"
}

Main() {

  if [ -f ./.env ]; then
    . ./.env
  fi

  if [ -f ./.env.deploy ]; then
    . ./.env.deploy
  fi

  if [ -f ./.docker.release.vars ]; then
    . ./.docker.release.vars
  fi

  local REMOTE_HOME="/home/${REMOTE_USER? Missing env var REMOTE_USER}"

  local DATETIME=$(date +%s)

  local DOCKER_IMAGE="${APP_VENDOR}/${PUBLIC_DOMAIN}:${APP_NAME}-${DATETIME}"
  local REMOTE_APP_DIR="${REMOTE_HOME}/${PUBLIC_DOMAIN}"

  SSH_Remote_Execute "mkdir -p ${REMOTE_APP_DIR}"

  SCP_Copy_To_Remote "docker-compose.yml"
  SCP_Copy_To_Remote ".env.deploy"
  SSH_Remote_Execute "mv ${REMOTE_APP_DIR}/.env.deploy ${REMOTE_APP_DIR}/.env"
  # Done this way because the docker image is using a timestamp in the tag.
  SSH_Remote_Execute "echo 'RELEASE_DOCKER_IMAGE=${DOCKER_IMAGE}' >> ${REMOTE_APP_DIR}/.env"

  Docker_Build_Release

  SSH_Remote_Docker_Load

  SSH_Remote_Execute "cd ${REMOTE_APP_DIR} && docker-compose up --detach app"

  SSH_Remote_Execute "cd ${REMOTE_APP_DIR} && docker-compose logs --tail 100"
}

Main "${@}"
