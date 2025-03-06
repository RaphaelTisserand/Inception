# syntax=docker/dockerfile:1

FROM debian:bookworm

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install mariadb-server -y
apt-get clean
rm -rf /var/lib/apt/lists/*
systemctl enable mariadb
mysql_secure_installation
EOF

COPY ./conf/mariadb.conf .etc/mariadb

EXPOSE 3306

ENTRYPOINT ["mariadb"]
