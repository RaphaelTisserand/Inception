# syntax=docker/dockerfile:1

FROM debian:bookworm

# EXPOSE 9000

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install php php-fpm php-mysql php-common php-gd php-mysqlnd php-phar php-mbstring php-iconv mariadb-client curl -y
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /etc/wordpress
EOF

COPY ./tools/myscript.sh /etc/wordpress/myscript.sh
COPY ./conf/www.conf /etc/php/php.fpm.d/www.conf

RUN chmod +x /etc/wordpress/myscript.sh
RUN chmod +x /etc//php/php.fpm.d/www.conf

ENTRYPOINT ["/etc/wordpress/myscript.sh"]
