# syntax=docker/dockerfile:1

FROM debian:bookworm

EXPOSE 9000

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install php7.4 pfp-fpm php-mysql mariadb-client -y
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

# COPY ./conf/wordpress.conf ./etc/wordpress/

# RUN chown -R www-data:www-data /var/www/html
