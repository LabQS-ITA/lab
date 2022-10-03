FROM ubuntu:focal AS virtualminbase

ARG HOST_NAME

RUN apt update && apt upgrade -y
RUN apt install wget
RUN mkdir -p dist
WORKDIR dist
RUN wget -r https://software.virtualmin.com/gpl/scripts/install.sh
RUN sh ./install.sh --hostname ${HOST_NAME} --minimal --force --verbose
