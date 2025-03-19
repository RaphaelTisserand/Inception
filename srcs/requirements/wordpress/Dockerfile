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
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
EOF

COPY ./tools/myscript.sh /etc/
COPY ./conf/wordpress.conf /etc/wordpress/

RUN ["chmod", "u+x", "/myscript.sh"]

ENTRYPOINT ["/etc/myscript.sh"]
