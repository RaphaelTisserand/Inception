# syntax=docker/dockerfile:1

FROM debian:bookworm

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install nginx openssl -y
apt-get clean
rm -r -f /var/lib/apt/lists/*
mkdir -p /etc/nginx/ssl /var/www/html
openssl req \
	-x509 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt \
	-days 365 \
	-noenc \
	-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42Paris/CN=rtissera.42.fr/UID=rtissera/emailAddress=rtissera@student.42.fr'
EOF

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN ["chmod", "+x", "/etc/nginx/nginx.conf"]
RUN ["chown", "-R", "www-data:www-data", "/var/www/html"]

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
