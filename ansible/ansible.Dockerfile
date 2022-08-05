FROM centos:latest

RUN dnf -y install epel-release

RUN dnf makecache

RUN dnf -y install ansible

CMD ["/sbin/init"]