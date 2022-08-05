FROM alpine:latest

RUN mkdir -p /etc/ansible
RUN apk add ansible

EXPOSE 22
