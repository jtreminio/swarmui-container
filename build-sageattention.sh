#!/usr/bin/env bash
set -e
set -o pipefail

# Build SageAttention 2
cd /workspace/sageattention
python setup.py install
python setup.py bdist_wheel
cp -av /workspace/sageattention/dist/*.whl /workspace/wheels

# Build SageAttention 3 Blackwell
cd /workspace/sageattention/sageattention3_blackwell
python setup.py install
python setup.py bdist_wheel
cp -av /workspace/sageattention/sageattention3_blackwell/dist/*.whl /workspace/wheels
