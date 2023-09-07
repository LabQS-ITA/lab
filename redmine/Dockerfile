FROM docker.io/redmine:alpine AS redminebase

USER root

RUN sed -i '/edge/s/^#//' /etc/apk/repositories
RUN cat /etc/apk/repositories
RUN apk add envconsul
