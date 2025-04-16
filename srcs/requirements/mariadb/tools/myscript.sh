#!/bin/sh

service mariadb start

sleep 3

echo "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;" | mariadb -u root
echo "CREATE USER IF NOT EXISTS $SQL_USER@'localhost' IDENTIFIED BY '$SQL_PASSWORD';" | mariadb -u root
echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO $SQL_USER@'%' IDENTIFIED BY '$SQL_PASSWORD';" | mariadb -u root
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';" | mariadb -u root
echo "FLUSH PRIVILEGES;" | mariadb -u root -p$SQL_ROOT_PASSWORD

kill $(cat /var/run/mysqld/mysqld.pid)

sleep 3

exec mysqld_safe
