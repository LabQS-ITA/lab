FROM centos:latest

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's/#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y install crontabs NetworkManager \
    firewalld selinux-policy sudo python3-firewall initscripts python3

RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount \
    graphical-target systemd-logind.service \
    NetworkManager.service systemd-hostnamed.service
STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]