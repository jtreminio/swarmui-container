#!/usr/bin/env bash
set -e
set -o pipefail

export TORCH_CUDA_ARCH_LIST="12.0"
export CUDA_ARCH_LIST="12.0"
export MAX_JOBS=8
export CUDA_HOME=/usr/local/cuda
export CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda
export CUDNN_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:-}
export PYTORCH_VERSION="$(python -c 'import torch; print(torch.__version__)')"
export USE_CUDA=1
export USE_CUDNN=1
export USE_CUSPARSELT=1

PYBIND11_INC="$(python -c 'import pybind11, sys; print(pybind11.get_include())')"
export CPATH="$PYBIND11_INC${CPATH:+:$CPATH}"
export CXXFLAGS="-I$PYBIND11_INC ${CXXFLAGS:-}"

# CCCL headers for x86_64
export CPLUS_INCLUDE_PATH=/usr/local/cuda/targets/x86_64-linux/include/cccl:${CPLUS_INCLUDE_PATH:-}
export CPATH=/usr/local/cuda/targets/x86_64-linux/include/cccl:${CPATH}

echo "=== Starting sageattention build ==="
source /workspace/compile-sageattention.sh
echo "=== Finished sageattention, exit code: $? ==="

echo "=== Starting torchaudio build ==="
source /workspace/compile-torchaudio.sh
echo "=== Finished torchaudio, exit code: $? ==="
