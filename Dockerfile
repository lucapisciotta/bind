FROM alpine:latest

RUN set -ue \
    ; apk update \
    ; apk upgrade \
    ; apk add bind \
    ; mkdir /etc/bind/zones \
    ; rndc-confgen > /etc/bind/rndc.key \
    ; chmod 644 /etc/bind/rndc.key \
;

COPY named.conf named.conf.local named.conf.options named.conf.default-zones /etc/bind/
COPY zones /etc/bind/zones

ENTRYPOINT ["named", "-g"]