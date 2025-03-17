# syntax=docker/dockerfile:1

FROM debian:bookworm

EXPOSE 3306

LABEL maintainer="Raphael TISSERAND <rtissera@student.42.fr>"

RUN <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install mariadb-server -y
apt-get clean
rm -rf /var/lib/apt/lists/*
cp ./conf/myscript.sh /myscript.sh
sed -i s/^bind-adress.*$/bind-adress = 0.0.0.0/g /etc/mysql/mariadb.conf.d/50-server.cnf
chmod u+x /start_script.sh
EOF

ENTRYPOINT ["/myscript.sh"]
