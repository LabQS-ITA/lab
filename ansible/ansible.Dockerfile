FROM alpine:ansible

RUN mkdir -p /etc/ansible
RUN apk add ansible

EXPOSE 22
