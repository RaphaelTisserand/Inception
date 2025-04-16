#!/bin/sh

sleep 30

cd /var/www/html/

rm -f wp-config.php

wp config create \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3360 \
	--skip-check \
	--allow-root

wp core install \
	--url=$DOMAIN_NAME \
	--title=$SITE_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root

wp user create $WP_USER $WP_EMAIL \
	--role=author \
	--user_pass=$WP_PASSWORD \
	--allow-root

exec /usr/sbin/php-fpm7.4 -F
