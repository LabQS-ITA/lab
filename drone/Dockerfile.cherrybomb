FROM alpine:latest as cherrybombbase

USER root

RUN apk add curl sudo && \
    curl https://cherrybomb.blstsecurity.com/install | /bin/sh
