FROM alpine:latest

RUN mkdir -p /etc/ansible
RUN apk add ansible

RUN ssh-keygen -t rsa -P ""

RUN ssh-copy-id -i ~/.ssh/id_rsa.pub 172.1.5.200

EXPOSE 22
