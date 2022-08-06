FROM alpine:latest

RUN mkdir -p /etc/ansible
RUN apk update
RUN apk add --no-cache openrc
RUN apk add --no-cache ansible
RUN apk add --no-cache openssh

RUN useradd -ms /bin/sh gpes
RUN sudo usermod --password $(echo p4ssw0rd | openssl passwd -1 -stdin) gpes

USER gpes

RUN ssh-keygen -t rsa -P "" -f /home/gpes/.ssh/id_rsa

RUN ssh-copy-id -i ~/.ssh/id_rsa.pub 161.24.23.95
RUN ssh-copy-id -i ~/.ssh/id_rsa.pub 161.24.23.96

EXPOSE 22
