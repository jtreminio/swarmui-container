#!/usr/bin/env bash
set -e
set -o pipefail

CONTAINER_VERSION="$(tr -d '[:space:]' < VERSION)"

docker tag jtreminio/swarmui-wheels:${CONTAINER_VERSION} jtreminio/swarmui-wheels:latest
docker tag jtreminio/swarmui:${CONTAINER_VERSION} jtreminio/swarmui:latest

docker push jtreminio/swarmui-wheels:${CONTAINER_VERSION}
docker push jtreminio/swarmui-wheels:latest
docker push jtreminio/swarmui:${CONTAINER_VERSION}
docker push jtreminio/swarmui:latest