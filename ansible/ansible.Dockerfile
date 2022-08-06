FROM alpine:latest

RUN mkdir -p /etc/ansible
RUN apk update
RUN apk add --no-cache openrc
RUN apk add --no-cache ansible
RUN apk add --no-cache openssh

RUN addgroup -S ansible
RUN adduser -s /bin/sh -S ansible -G ansible

RUN PW=$(echo p4ssw0rd | base64) && echo -e "$PW\n$PW" | passwd ansible && unset PW

USER ansible

RUN ssh-keygen -t rsa -P "" -C "ansible@161.24.23.96" -f ~/.ssh/id_rsa

RUN echo "p4ssw0rd" | cat ~/.ssh/id_rsa.pub | ssh -p 2222 gpes@161.24.23.96 'cat >> .ssh/authorized_keys'

EXPOSE 22
