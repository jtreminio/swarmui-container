#!/usr/bin/env bash
set -e
set -o pipefail

CONTAINER_VERSION="$(tr -d '[:space:]' < VERSION)"

docker image build \
    --build-arg CONTAINER_VERSION=${CONTAINER_VERSION} \
    -f Dockerfile \
    -t "jtreminio/swarmui:${CONTAINER_VERSION}" \
    .
