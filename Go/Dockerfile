FROM ubuntu:latest

RUN apt update && apt upgrade -y

RUN apt install curl wget tar -y

RUN GO_URL=$(wget -qO- https://go.dev/dl/ | grep -oP "go([0-9\.]+)\.linux-$(dpkg --print-architecture)\.tar\.gz" | head -n 1) && \
  GO_URL=https://dl.google.com/go/$GO_URL && \
  wget $GO_URL -O /tmp/go.tar.gz

RUN tar -C /usr/local -xzf /tmp/go.tar.gz

ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH
