FROM alpine:latest

RUN mkdir -p /etc/ansible
RUN apk add ansible

RUN ssh-keygen -t rsa -P ""

EXPOSE 22
