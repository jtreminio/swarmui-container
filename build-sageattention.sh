#!/usr/bin/env bash
set -e
set -o pipefail

cd /workspace/sageattention
python setup.py install
python setup.py bdist_wheel
cp -av /workspace/sageattention/dist/*.whl /workspace/wheels

cd /workspace/sageattention/sageattention3_blackwell
python setup.py install
python setup.py bdist_wheel
cp -av /workspace/sageattention/sageattention3_blackwell/dist/*.whl /workspace/wheels
