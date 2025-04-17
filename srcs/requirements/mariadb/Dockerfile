# syntax=docker/dockerfile:1

FROM debian:bullseye

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install mariadb-server -y
apt-get clean
rm -r -f /var/lib/apt/lists/*
EOF

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/myscript.sh .

RUN ["chmod", "+x", "myscript.sh"]

ENTRYPOINT ["./myscript.sh"]
