FROM ubuntu:focal AS virtualminbase

ENV HOST_NAME

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget
RUN mkdir -p dist
WORKDIR dist
RUN wget https://software.virtualmin.com/gpl/scripts/install.sh
RUN chmod g+x ./install.sh
RUN ./install.sh --hostname ${HOST_NAME} --minimal --force --verbose
