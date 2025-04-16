#!/bin/sh

SQL_IP=$(getent hosts $SQL_DATABASE | awk '{ print $1 }')
echo "$SQL_IP $SQL_DATABASE" >> /etc/hosts
exec 2>&1

cd /var/www/html/

rm -f wp-config.php

wp config create \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3360 \
	--skip-check \
	--allow-root \
	--path='/var/www/html'

until wp db check --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --path=/var/www/html --quiet --allow-root; do
	echo "Waiting for MySQL..."
	sleep 1
done

wp core install \
	--url=$DOMAIN_NAME \
	--title=$SITE_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root \
	--path='/var/www/html'

wp user create $WP_USER $WP_EMAIL \
	--role=suscriber \
	--user_pass=$WP_PASSWORD \
	--allow-root \
	--path='/var/www/html'

exec /usr/sbin/php-fpm7.4 -F
