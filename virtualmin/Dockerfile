FROM ubuntu:focal AS virtualminbase

ENV HOST_NAME test.labqs.ita.br

USER root

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget
RUN mkdir -p dist
WORKDIR dist
RUN wget https://software.virtualmin.com/gpl/scripts/install.sh
RUN chmod g+x ./install.sh
# RUN ./install.sh --hostname ${HOST_NAME} --minimal --force --verbose

EXPOSE 80 443 21 25 110 143 465 587 993 995 2122 10000 20000 53/udp 53/tcp

# ENTRYPOINT ["/usr/bin/systemctl","default","--init"]
