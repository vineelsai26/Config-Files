FROM ubuntu:latest

# Set Timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and Upgrade
RUN apt update && apt upgrade -y

# Install Basic Tools
RUN apt install git wget curl zsh sudo tar ca-certificates gnupg lsb-release -y

# Install Go
WORKDIR /tmp

RUN GO_URL=$(wget -qO- https://go.dev/dl/ | grep -oP "go([0-9\.]+)\.linux-$(dpkg --print-architecture)\.tar\.gz" | head -n 1) && \
  GO_URL=https://dl.google.com/go/$GO_URL && \
  wget $GO_URL -O /tmp/go.tar.gz

RUN tar -C /usr/local -xzf /tmp/go.tar.gz

ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH

# Install Python
RUN apt install python3 python3-pip python-is-python3 -y

# Install Java
RUN apt install default-jre default-jdk -y

# Install C/C++
RUN apt install gcc g++ clang lldb lld -y

# Install NodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -

RUN apt install nodejs -y

RUN npm i -g npm

RUN npm i -g yarn

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update
RUN apt install docker-ce docker-ce-cli containerd.io -y
