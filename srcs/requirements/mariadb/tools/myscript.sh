#!/bin/sh

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ -f /var/lib/mysql/.installed ]; then
	echo "MariaDB already installed."
else
	mariadb-install-db --user mysql
	mariadbd --bootstrap --user mysql <<EOF
	FLUSH PRIVILEGES;
	CREATE DATABASE $SQL_DATABASE;
	CREATE USER "$SQL_USER"@'%' IDENTIFIED BY "$SQL_PASSWORD";
	GRANT ALL PRIVILEGES ON $SQL_DBNAME.* TO "$SQL_USER"@'%' IDENTIFIED BY "$SQL_PASSWORD";
	FLUSH PRIVILEGES;
	exit
EOF
	touch /var/lib/mysql/.installed
fi

exec mariadbd --user mysql
