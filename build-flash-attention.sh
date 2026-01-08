#!/usr/bin/env bash
set -e
set -o pipefail

export FLASH_ATTN_CUDA_ARCHS="120"

cd /workspace/flash-attention
python setup.py install
python setup.py bdist_wheel
cp -av /workspace/flash-attention/dist/*.whl /workspace/wheels
