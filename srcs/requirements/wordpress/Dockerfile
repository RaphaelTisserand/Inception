# syntax=docker/dockerfile:1

FROM debian:bullseye

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install php7.4 php-fpm php-mysql mariadb-client curl wget -y
apt-get clean
rm -r -f /var/lib/apt/lists/*
EOF

COPY ./conf/www.conf  /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/myscript.sh .
RUN ["chmod", "+x", "./myscript.sh"]

RUN mkdir -p /run/php

ENTRYPOINT ["./myscript.sh"]
