#!/usr/bin/env bash
set -e
set -o pipefail

export USE_FFMPEG=1
export BUILD_SOX=1
export TORIO_USE_FFMPEG_VERSION=6
export CMAKE_ARGS="-DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc -DCUDAToolkit_ROOT=/usr/local/cuda"

cd /workspace/torchaudio
rm -rf build dist *.egg-info
python -m pip install -v . --no-build-isolation --no-deps
python -m pip wheel -v . --no-build-isolation --no-deps -w /workspace/wheels
