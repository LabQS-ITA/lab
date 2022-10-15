FROM ubuntu:latest as openstackbase

ENV OPENSTACK_HOST=172.1.4.200

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y git vim && \
    mkdir -p /opt/stack

WORKDIR /opt/stack

RUN git clone https://opendev.org/openstack/devstack && \
    useradd -s /bin/bash -d /opt/stack -m stack && \
    echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack

USER stack

RUN  cd devstack && \
    echo "[[local|localrc]]" > local.conf && \
    echo "ADMIN_PASSWORD=p4ssw0rd" >> local.conf && \
    echo "DATABASE_PASSWORD=$ADMIN_PASSWORD" >> local.conf && \
    echo "RABBIT_PASSWORD=$ADMIN_PASSWORD" >> local.conf && \
    echo "SERVICE_PASSWORD=$ADMIN_PASSWORD" >> local.conf && \
    echo "IPV4_ADDRS_SAFE_TO_USE=172.31.1.0/24" >> local.conf && \
    echo "FLOATING_RANGE=192.168.20.0/25" >> local.conf && \
    echo "HOST_IP=$OPENSTACK_HOST" >> local.conf && \
    ./stack.sh
