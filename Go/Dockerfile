FROM ubuntu:latest

RUN apt update && apt upgrade -y

RUN GO_URL="https://go.dev/dl/$(wget -qO- https://go.dev/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)"
RUN wget $GO_URL -O /tmp/go.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz

ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH
