FROM --platform=linux/amd64 python:3.10-bullseye

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    protobuf-compiler curl

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain 1.79.0 -y
RUN export PATH="$PATH:$HOME/. cargo/bin"
RUN pip3 install maturin virtualenv

RUN dpkg --add-architecture arm64 \
    && dpkg --add-architecture armhf

RUN apt-get update &&  apt-get -y install \
    ca-certificates \
    pkg-config \
    cmake \
    build-essential \
    crossbuild-essential-arm64 \
    protobuf-compiler \
    libssl-dev \
    libssl-dev:arm64 \
    && rm -rf /var/lib/apt/lists/*

# RUN rustup target add aarch64-unknown-linux-gnu
# RUN rustup component add rustfmt && rustup component add clippy
