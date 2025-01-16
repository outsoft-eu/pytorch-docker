FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    python3-pip \
    git \
    ca-certificates \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN git clone --branch v2.5.1 --depth 1 https://github.com/pytorch/pytorch.git /pytorch
WORKDIR /pytorch
RUN git submodule sync && git submodule update --init --recursive
RUN pip install --no-cache-dir -r requirements.txt
ENV USE_CUDA=1
ENV USE_CUDNN=1
RUN python3 setup.py install
