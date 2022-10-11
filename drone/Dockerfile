FROM drone/drone:latest as dronebase

USER root

RUN apk add curl sudo && \
    curl https://cherrybomb.blstsecurity.com/install | /bin/sh
