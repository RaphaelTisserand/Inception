# syntax=docker/dockerfile:1

FROM debian:bookworm

EXPOSE 9000

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install php7.4 pfp-fpm php-mysql mariadb-client curl -y
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /etc/wordpress
EOF

COPY ./tools/myscript.sh /etc/wordpress/myscript.sh
COPY ./conf/www.conf /etc/wordpress/myscript.sh

RUN ["chmod", "u+x", "/etc/wordpress/myscript.sh"]

ENTRYPOINT ["/etc/wordpress/myscript.sh"]
