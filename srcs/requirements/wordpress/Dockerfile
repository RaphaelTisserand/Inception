# syntax=docker/dockerfile:1

FROM debian:bookworm

EXPOSE 9000

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install php82 php82-fpm php82-mysql php82-common php82-gd php82-mysqlnd php82-phar php82-mbstring php82-iconv mariadb-client curl -y
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /etc/wordpress
EOF

COPY ./tools/myscript.sh /etc/wordpress/myscript.sh
COPY ./conf/www.conf /etc/php82/php.fpm.d/www.conf

RUN ["chmod", "u+x", "/etc/wordpress/myscript.sh"]

ENTRYPOINT ["/etc/wordpress/myscript.sh"]
