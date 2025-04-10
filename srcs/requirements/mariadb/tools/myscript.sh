#!/bin/sh

if [ -d "/var/lib/mysql/$SQL_DATABASE" ]; then
	echo "MariaDB already installed."
else
	service mariadb start

	sleep 3

	echo "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;" | mariadb -u root
	echo "CREATE USER IF NOT EXISTS $SQL_USER@'localhost' IDENTIFIED BY '$SQL_PASSWORD';" | mariadb -u root
	echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO $SQL_USER@'localhost' IDENTIFIED BY '$SQL_PASSWORD';" | mariadb -u root
	echo "FLUSH PRIVILEGES;" | mariadb -u root

	service mariadb start
fi

sleep 3

exec mysqld_safe
