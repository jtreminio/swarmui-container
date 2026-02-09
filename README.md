# swarm-container

This repo builds a [SwarmUI](https://github.com/mcmonkeyprojects/SwarmUI)-ready container with:

* [Nvidia PyTorch Container 26.01-py3](https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel-26-01.html)
    * python 3.12.3
    * cuda 13.1.1
    * torch 2.10.0
    * pytorch-triton 3.6.0
* [sageattn3](https://github.com/thu-ml/SageAttention/tree/main/sageattention3_blackwell)
* [sageattention 2.2.0](https://github.com/thu-ml/SageAttention/tree/main)
* [flash-attn 2.7.4](https://github.com/Dao-AILab/flash-attention)
* [torchaudio 2.9.1](https://github.com/pytorch/audio)

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
docker run --gpus all -it -d --shm-size=8g --restart=always --name swarmui \
    -p 7801:7801 \
    -v /path/to/SwarmUI:/workspace \
    -v swarm_pip:/usr/local/lib/python3.12/dist-packages \
    jtreminio/swarmui:26.01-py3
```

Then navigate to [http://localhost:7801/](http://localhost:7801/).

## Define different model and config paths

```bash
docker run --gpus all -it -d --shm-size=8g --restart=always --name swarmui \
    -p 7801:7801 \
    -v /path/to/SwarmUI:/workspace \
    -v swarm_pip:/usr/local/lib/python3.12/dist-packages \
    -v /path/to/local/output_directory:/workspace/Output \
    -v /path/to/local/wildcard_directory:/workspace/Data/Wildcards \
    jtreminio/swarmui:26.01-py3
```

Then navigate to [http://localhost:7801/](http://localhost:7801/).

# More Tags

See all available tags at [https://hub.docker.com/r/jtreminio/swarmui](https://hub.docker.com/r/jtreminio/swarmui).

# Building

If you would like to build the image for yourself, simply run:

```bash
# compiles sageattention, torchaudio, etc
./step-1.sh
# builds the Docker image for reuse
./step-2.sh
```

There are two steps because `docker build` does not have a `--gpus all` option, so you cannot compile anything that requires a GPU.
