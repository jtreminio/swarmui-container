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

if [[ ! -d "torchaudio" ]]; then
    git clone https://github.com/Dao-AILab/flash-attention.git flash-attention
fi

# if flash_attn-2.7.4+cu130torch2.9-cp312-cp312-linux_x86_64.whl not in wheels directory, download it
if [[ ! -f "wheels/flash_attn-2.7.4+cu130torch2.9-cp312-cp312-linux_x86_64.whl" ]]; then
    curl -L https://github.com/mjun0812/flash-attention-prebuild-wheels/releases/download/2.7.4/flash_attn-2.7.4+cu130torch2.9-cp312-cp312-linux_x86_64.whl -o wheels/flash_attn-2.7.4+cu130torch2.9-cp312-cp312-linux_x86_64.whl
fi

cd torchaudio && git checkout release/2.9 && cd ..

docker run --gpus all --rm -it --shm-size=512m \
    -v "${PWD}:/workspace" \
    "nvcr.io/nvidia/pytorch:${CONTAINER_VERSION}" \
    /bin/bash -c "bash compile-sageattention.sh && bash compile-torchaudio.sh"
