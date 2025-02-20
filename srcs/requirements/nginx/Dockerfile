# syntax=docker/dockerfile:1

FROM debian:stable

RUN <<eof
apt-get update
apt-get dist-upgrade -y
apt-get install -y nginx
apt-get clean
eof

COPY /conf/ngingx.conf /etc/nginx/

ENTRYPOINT ["ngingx", "-g", "daemon off;"]
