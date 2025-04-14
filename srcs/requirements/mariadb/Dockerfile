# syntax=docker/dockerfile:1

FROM debian:bullseye

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install mariadb-server -y
apt-get clean
rm -r -f /var/lib/apt/lists/*
mkdir -p /run/mysqld
EOF

COPY ./conf/my.cnf /root/my.cnf
COPY ./tools/myscript.sh .

RUN <<EOF
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
chmod +x ./myscript.sh
EOF

EXPOSE 3306

ENTRYPOINT ["./myscript.sh"]
