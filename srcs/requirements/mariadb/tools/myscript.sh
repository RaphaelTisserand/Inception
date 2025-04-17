#!/bin/sh

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

mysql_install_db

service mysql start

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';" >>/etc/mysql/init.sql
echo "CREATE DATABASE $SQL_DATABASE;" >>/etc/mysql/init.sql
echo "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';" >>/etc/mysql/init.sql
echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';" >>/etc/mysql/init.sql
echo "FLUSH PRIVILEGES;" >>/etc/mysql/init.sql

exec mysqld --user=mysql --console
