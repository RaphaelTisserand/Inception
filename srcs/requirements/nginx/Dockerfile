# syntax=docker/dockerfile:1

FROM debian:bookworm

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install nginx openssl vim curl -y
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /etc/nginx/certificates
openssl req \
		-x509 \
		-newkey rsa:2048 \
		-keyout /etc/nginx/ssl/inception.key \
		-out /etc/nginx/ssl/inception.crt \
		-days 365 \
		-nodes \
		-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42Paris/CN=Raphael TISSERAND/UID=rtissera'
EOF

COPY /conf/nginx.conf /etc/nginx/

RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
