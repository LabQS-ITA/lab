FROM docker.io/ansiblesemaphore/semaphore:latest AS semaphorebase

USER root

RUN apk add rsync

RUN python3 -m ensurepip
RUN pip3 install ansible --upgrade
