ARG CONTAINER_VERSION=25.10-py3
FROM nvcr.io/nvidia/pytorch:${CONTAINER_VERSION}
LABEL maintainer="Juan Treminio <jtreminio@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_INSTALL_DIR=/usr/share/dotnet
ENV DOTNET_ROOT=${DOTNET_INSTALL_DIR}

RUN apt update &&\
    apt install -y libgl1-mesa-dev ffmpeg libglib2.0-0 libgl1 &&\
    apt-get autoclean &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}

RUN curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh &&\
    chmod +x /tmp/dotnet-install.sh &&\
    /tmp/dotnet-install.sh --version latest --install-dir "${DOTNET_INSTALL_DIR}" &&\
    rm -f /tmp/dotnet-install.sh

ENV PATH="${DOTNET_INSTALL_DIR}:${PATH}"

COPY wheels /tmp/wheels
RUN python -m pip install --upgrade \
    rotary_embedding_torch>=0.8.9 \
    safetensors>=0.7.0 \
    SQLAlchemy>=2.0.45 \
    torchao>=0.15.0 \
    torchsde>=0.2.6 \
    tokenizers>=0.22.2 \
    triton>=3.5.1 \
    &&\
    python -m pip install --no-cache-dir /tmp/wheels/*.whl \
    && rm -rf /tmp/wheels

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libcuda.so.1
ENV SWARM_NO_VENV=true
RUN git config --global --add safe.directory '*'
EXPOSE 7801

ENTRYPOINT ["bash", "/workspace/launch-linux-dev.sh", "--launch_mode", "none", "--host", "0.0.0.0"]
