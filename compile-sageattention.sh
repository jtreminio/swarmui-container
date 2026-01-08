#!/usr/bin/env bash
set -e
set -o pipefail

python -m pip install -U wheel setuptools

cd /workspace/sageattention
python setup.py install
python setup.py bdist_wheel
cp -av /workspace/sageattention/dist/*.whl /workspace/wheels

cd /workspace/sageattention/sageattention3_blackwell
python setup.py install
python setup.py bdist_wheel
cp -av /workspace/sageattention/sageattention3_blackwell/dist/*.whl /workspace/wheels
