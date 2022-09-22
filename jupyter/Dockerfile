FROM jupyterhub/jupyterhub:latest as jupyterhubbase

ARG GPES_PASSWORD=s3cr37
ARG GPES_DEV_PASSWORD=s3cr37

USER root

RUN pip3 install jupyter_server --upgrade

RUN pip3 install jupyter_server

RUN adduser --disabled-password --gecos "" gpes
RUN usermod --password $(echo ${GPES_PASSWORD} | openssl passwd -1 -stdin) gpes

RUN adduser --disabled-password --gecos "" gpesdev
RUN usermod --password $(echo ${GPES_DEV_PASSWORD} | openssl passwd -1 -stdin) gpesdev
