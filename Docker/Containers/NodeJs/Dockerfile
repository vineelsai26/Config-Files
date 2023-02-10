FROM ubuntu:latest

ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV NVS_HOME "$HOME/.nvs"

RUN apt update && apt upgrade -y

RUN apt install curl git -y

RUN git clone https://github.com/jasongin/nvs "$NVS_HOME"

ENV PATH "$NVS_HOME:$PATH"

RUN . "$NVS_HOME/nvs.sh" install

RUN nvs add lts

RUN . "$NVS_HOME/nvs.sh" install && nvs use lts

# RUN . "$NVS_HOME/nvs.sh" install && nvs link lts

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt install nodejs -y

RUN npm i -g npm

RUN npm i -g yarn
