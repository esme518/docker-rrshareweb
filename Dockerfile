#
# Dockerfile for rrshareweb
#

FROM alpine:latest

ARG GLIBC_VER="2.32-r0"
ENV GLIBC_URL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk
ENV GLIBCBIN_URL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk
ENV RRSHARE_URL http://appdown.rrys.tv/rrshareweb_centos7.tar.gz

RUN set -ex \
    && apk add --update --no-cache \
        libstdc++ \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget $GLIBC_URL \
    && wget $GLIBCBIN_URL \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && rm -rf glibc* \
    && wget -q -O /rrshareweb.tar.gz $RRSHARE_URL \
    && tar zxvf /rrshareweb.tar.gz -C /etc/ \
    && rm -rf /rrshareweb.tar.gz \
    && rm -rf /var/cache/apk

VOLUME ["/opt/work/store"]

ENV PATH /etc/rrshareweb:$PATH

EXPOSE 3001

CMD ["rrshareweb"]
