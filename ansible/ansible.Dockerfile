FROM alpine:latest

RUN mkdir -p /etc/ansible
RUN apk update
RUN apk add --no-cache openrc
RUN apk add --no-cache ansible
RUN apk add --no-cache openssh

RUN addgroup -S gpes
RUN adduser -s /bin/sh -S gpes -G gpes

RUN PW=$(echo p4ssw0rd | base64) && echo -e "$PW\n$PW" | passwd gpes && unset PW

USER gpes

RUN ssh-keygen -t rsa -P "" -f /home/gpes/.ssh/id_rsa

RUN ssh-copy-id -p 2222 -i ~/.ssh/id_rsa.pub 161.24.23.95
RUN ssh-copy-id -p 2222 -i ~/.ssh/id_rsa.pub 161.24.23.96

EXPOSE 22
