# syntax=docker/dockerfile:1

FROM debian:bullseye

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

EXPOSE 3306

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install mariadb-server curl -y
apt-get clean
rm -r -f /var/lib/apt/lists/*
mkdir -p /etc/mariadb /etc/mysql
EOF

COPY ./conf/my.cnf /root/
COPY ./tools/myscript.sh .

RUN ["chmod", "+x", "./myscript.sh"]

ENTRYPOINT ["./myscript.sh"]
