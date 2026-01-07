#!/usr/bin/env bash
set -e
set -o pipefail

cd /workspace/torchaudio
apt update
apt update && apt install -y libsox-dev libavformat-dev libavcodec-dev libavutil-dev libavdevice-dev ffmpeg libavfilter-dev libswresample-dev libswscale-dev
pip install -U pynvml>=12.0.0 sentencepiece soundfile cmake ninja cupy-cuda13x cuda-python nvidia-ml-py pybind11 torchcodec

export PYTORCH_VERSION="$(python3 -c 'import torch; print(torch.__version__)')"
export USE_CUDA=1
export USE_FFMPEG=1
export BUILD_SOX=1
export TORIO_USE_FFMPEG_VERSION=6  
export TORCH_CUDA_ARCH_LIST="8.7 9.0 10.0 11.0+PTX"
export CUDA_ARCH_LIST="8.7 9.0 10.0 11.0"
export USE_CUDNN=1
export USE_CUSPARSELT=1
PYBIND11_INC="$(python3 -c 'import pybind11, sys; print(pybind11.get_include())')"
export CPATH="$PYBIND11_INC${CPATH:+:$CPATH}"
export CXXFLAGS="-I$PYBIND11_INC ${CXXFLAGS:-}"
export CPLUS_INCLUDE_PATH=/usr/local/cuda-13.0/targets/sbsa-linux/include/cccl:${CPLUS_INCLUDE_PATH}
export CPATH=/usr/local/cuda-13.0/targets/sbsa-linux/include/cccl:${CPATH}
export MAX_JOBS=8 

BUILD_SOX=1 TORCH_CUDA_ARCH_LIST=11.0 USE_CUDA=1 python3 -m pip install -v . --no-use-pep517 --no-build-isolation --no-deps
BUILD_SOX=1 TORCH_CUDA_ARCH_LIST=11.0 USE_CUDA=1 python3 -m pip wheel -v . --no-use-pep517 --no-build-isolation --no-deps -w /workspace/wheels
