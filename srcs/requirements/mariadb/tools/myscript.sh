#!/bin/sh

systemctl enable mariadb
mysql_secure_installation --port=3306
