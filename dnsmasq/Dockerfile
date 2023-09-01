FROM alpine:edge AS dnsmasqbase

RUN apk update \
	&& apk --no-cache add dnsmasq

RUN mkdir -p /etc/default/ \
    && echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq

ENTRYPOINT ["dnsmasq", "-k"]
