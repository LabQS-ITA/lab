FROM alpine:latest

RUN mkdir -p /etc/ansible

RUN apk update
RUN apk add --no-cache openrc ansible openssh sshpass

RUN addgroup -S ansible && adduser -s /bin/sh -S ansible -G ansible
RUN PW=$(echo p4ssw0rd | base64) && echo -e "$PW\n$PW" | passwd ansible && unset PW

USER ansible

RUN ssh-keygen -t rsa -P "" -C "ansible@161.24.23.96" -f ~/.ssh/id_rsa
RUN sshpass -p "p4ssw0rd" ssh -p 2222 -o StrictHostKeyChecking=no ansible@161.24.23.96 'mkdir -p ~/.ssh'
RUN cat ~/.ssh/id_rsa.pub | sshpass -p "p4ssw0rd" ssh -p 2222 -o StrictHostKeyChecking=no ansible@161.24.23.96 'cat >> .ssh/authorized_keys'

EXPOSE 22
