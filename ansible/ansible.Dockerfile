FROM ubuntu:latest

RUN apt --yes update
RUN apt --yes install software-properties-common
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt --yes install ansible