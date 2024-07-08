FROM --platform=linux/amd64 python:3.10-bullseye

LABEL org.opencontainers.image.source=https://github.com/tomvictor/pyo3

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH 

RUN dpkg --add-architecture arm64 \
    && dpkg --add-architecture armhf

RUN apt-get update &&  apt-get -y install \
    ca-certificates \
    pkg-config \
    cmake \
    build-essential \
    crossbuild-essential-arm64 \
    protobuf-compiler \
    curl \
    libssl-dev \
    libssl-dev:arm64 \
    && rm -rf /var/lib/apt/lists/*

#Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain 1.79.0 -y
RUN echo $PATH
RUN export PATH="$PATH:$HOME/.cargo/bin"
RUN echo $PATH
RUN rustup target add aarch64-unknown-linux-gnu
RUN rustup component add rustfmt && rustup component add clippy

# Python deps
RUN pip3 install maturin virtualenv
