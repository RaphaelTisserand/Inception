# syntax=docker/dockerfile:1

FROM debian:bookworm

EXPOSE 3306

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install mariadb-server -y
sed -i s/^bind-adress.*$/bind-adress = 0.0.0.0/g /etc/mysql/mariadb.conf.d/50-server.cnf
apt-get clean
rm -rf /var/lib/apt/lists/*
chmod u+x ./conf/start_script.sh
EOF

COPY ./conf/mariadb.conf /etc/mariadb/

ENTRYPOINT ["./conf/myscript.sh"]
