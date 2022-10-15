FROM ubuntu:latest as openstackbase

ENV OPENSTACK_HOST=172.1.4.200

USER root

RUN apt-get update -y && apt-get upgrade -y && \
    useradd -s /bin/bash -d /opt/stack -m stack && \
    mkdir -p /etc/sudoers.d && \
    echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack && \
    apt install git vim

USER stack

RUN git clone https://opendev.org/openstack/devstack

WORKDIR /opt/stack/devstack

RUN ./stack.sh
