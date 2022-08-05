FROM alpine:latest

RUN mkdir -p /etc/ansible
RUN apk update
RUN apk add --no-cache ansible
RUN apk add --no-cache openssh

RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa

RUN ssh-copy-id -i ~/.ssh/id_rsa.pub 172.1.5.200

EXPOSE 22
