#!/usr/bin/env bash
set -e
set -o pipefail

cd /workspace/torchaudio

export USE_FFMPEG=1
export BUILD_SOX=1
export TORIO_USE_FFMPEG_VERSION=6

python -m pip install -v . --no-build-isolation --no-deps
python -m pip wheel -v . --no-build-isolation --no-deps -w /workspace/wheels
