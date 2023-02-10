FROM ubuntu:latest

ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV NVS_HOME "$HOME/.nvs"

RUN apt update && apt upgrade -y

RUN apt install curl git -y

RUN git clone https://github.com/jasongin/nvs "$NVS_HOME" && . "$NVS_HOME/nvs.sh" install && nvs add lts && nvs use lts && nvs link lts

RUN apt install npm -y

RUN npm i -g npm

RUN npm i -g yarn
