FROM ubuntu:latest as openstackbase

ENV OPENSTACK_HOST=172.1.4.200

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y git vim && \
    mkdir -p /opt/stack

WORKDIR /opt/stack/devstack

RUN git clone https://opendev.org/openstack/devstack

RUN ./stack.sh
