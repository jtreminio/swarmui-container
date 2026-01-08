#!/usr/bin/env bash
set -e
set -o pipefail

CONTAINER_VERSION="$(tr -d '[:space:]' < VERSION)"
mkdir -p wheels

if [[ ! -d "sageattention" ]]; then
    git clone https://github.com/thu-ml/SageAttention.git sageattention
fi

if [[ ! -d "torchaudio" ]]; then
    git clone https://github.com/pytorch/audio.git torchaudio
fi

pushd sageattention && git fetch && git pull && popd
pushd torchaudio && git checkout release/2.9 && git fetch && git pull && popd

docker image build \
    --build-arg CONTAINER_VERSION=${CONTAINER_VERSION} \
    -f Dockerfile-wheels \
    -t "jtreminio/swarmui-wheels:latest" .

docker run --gpus all --rm -it --shm-size=32g \
    -v "${PWD}:/workspace" \
    --mount source=ccache,target=/root/.cache/ccache \
    jtreminio/swarmui-wheels:latest \
    /bin/bash -c "bash build-wheels.sh"
