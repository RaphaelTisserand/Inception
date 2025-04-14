#!/bin/sh

echo "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;" >>/etc/mysql/init.sql
echo "CREATE USER IF NOT EXISTS $SQL_USER@'localhost' IDENTIFIED BY '$SQL_PASSWORD';" >>/etc/mysql/init.sql
echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO $SQL_USER@'localhost' IDENTIFIED BY '$SQL_PASSWORD';" >>/etc/mysql/init.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';" >>/etc/mysql/init.sql
echo "FLUSH PRIVILEGES;" >>/etc/mysql/init.sql

exec mysqld_safe
