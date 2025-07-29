FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    make \
    build-essential \
    texlive-full \
    inkscape \
    python3-pygments \
    aspell \
    bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data
SHELL ["/bin/bash", "-c"]
