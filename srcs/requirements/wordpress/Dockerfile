# syntax=docker/dockerfile:1

FROM debian:bullseye

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install php7.4 php-fpm php-mysql mariadb-client curl wget -y
apt-get clean
rm -r -f /var/lib/apt/lists/*
mkdir -p /etc/wordpress
wget https://fr.wordpress.org/wordpress-6.4-fr_FR.tar.gz -P /var/www
cd /var/www && tar -xzf wordpress-6.4-fr_FR.tar.gz && rm wordpress-6.4-fr_FR.tar.gz  
cp -r /var/www/wordpress/. /var/www/html
rm -r -f /var/www/wordpress
chown -R root:root /var/www/html
EOF

COPY ./conf/www.conf  /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp-cli.phar

COPY ./tools/myscript.sh .
RUN ["chmod", "+x", "./myscript.sh"]

RUN mkdir -p /run/php

ENTRYPOINT ["./myscript.sh"]
