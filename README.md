# swarm-container

This repo builds a [SwarmUI](https://github.com/mcmonkeyprojects/SwarmUI)-ready container with:

* [sageattn @ 3 (compiled)](https://github.com/thu-ml/SageAttention/tree/main/sageattention3_blackwell)
* [torchaudio @ 2.9.1 (compiled)](https://github.com/pytorch/audio)

It is built on top of the [nvidia PyTorch images nvcr.io/nvidia/pytorch](https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/index.html).

# Requirements

* A Blackwell GPU
    * RTX 50-series
    * RTX Pro 6000
    * RTX Pro 5000
* Docker or Podman

# Getting Started

The image is available on DockerHub, so all you need to do is have the [SwarmUI repo](https://github.com/mcmonkeyprojects/SwarmUI) cloned locally.
Replace `/path/to/SwarmUI` with the path you've cloned SwarmUI at locally and run one of the following:

## All model paths as default

```bash
docker run --gpus all --rm -it --shm-size=512m --name swarmui \
    -p 7801:7801 \
    -v /path/to/SwarmUI:/workspace \
    jtreminio/swarmui:latest
```

Then navigate to [http://localhost:7801/](http://localhost:7801/).

## Define different model and config paths

```bash
docker run --gpus all --rm -it --shm-size=512m --name swarmui \
    -p 7801:7801 \
    -v /path/to/SwarmUI:/workspace \
    -v /path/to/local/output_directory:/workspace/Output \
    -v /path/to/local/wildcard_directory:/workspace/Data/Wildcards \
    jtreminio/swarmui:latest
```

Then navigate to [http://localhost:7801/](http://localhost:7801/).

# Building

If you would like to build the image for yourself, simply run:

```bash
# compiles flash_attn, sageattention, torchaudio, etc
./step-1.sh
# builds the Docker image for reuse
./step-2.sh
```

There are two steps because `docker build` does not have a `--gpus all` option, so you cannot compile anything that requires a GPU.
