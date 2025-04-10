# syntax=docker/dockerfile:1

FROM debian:bullseye

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

EXPOSE 9000

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install php7.4 php-fpm php-mysql mariadb-client curl wget -y
apt-get clean
rm -r -f /var/lib/apt/lists/*
mkdir -p /run/php
EOF

RUN <<EOF
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
EOF

COPY ./conf/www.conf  /etc/php/7.4/fpm/pool.d/
COPY ./tools/myscript.sh .

RUN ["chmod", "+x", "./myscript.sh"]

ENTRYPOINT ["./myscript.sh"]
