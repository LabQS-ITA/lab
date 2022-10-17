FROM ubuntu:focal as openstackbase

RUN  apt-get update -y && apt upgrade -y && \
    apt-get install -y git sudo && \
    ln -sf /bin/bash /bin/sh && \
    useradd -s /bin/bash -d /opt/stack -m stack && \
    chmod +x /opt/stack && \
    echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack

USER stack
WORKDIR /opt/stack

RUN git clone https://opendev.org/openstack/devstack

WORKDIR /opt/stack/devstack

COPY local.conf /opt/stack/devstack/local.conf

RUN ./stack.sh
