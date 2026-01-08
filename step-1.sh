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

cd torchaudio && git checkout release/2.9 && cd ..

docker run --gpus all --rm -it --shm-size=512m \
    -v "${PWD}:/workspace" \
    "nvcr.io/nvidia/pytorch:${CONTAINER_VERSION}" \
    /bin/bash -c "bash compile-sageattention.sh && bash compile-torchaudio.sh"
