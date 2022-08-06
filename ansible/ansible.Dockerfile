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

RUN ssh-keygen -t rsa -P "" -C "ansible@161.24.23.96" -f /home/ansible/.ssh/id_rsa

# RUN ssh-copy-id -p 2222 -i /home/ansible/.ssh/id_rsa.pub ansible@161.24.23.96

EXPOSE 22
