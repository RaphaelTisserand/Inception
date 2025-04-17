#!/bin/sh

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html

wp core download --allow-root

rm -f /var/www/html/wp-config.php

wp config create \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 \
	--skip-check \
	--path=/var/www/html \
	--allow-root

until wp db check \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--path=/var/www/html \
	--quiet \
	--allow-root; do
	echo "Waiting for MySQL..."
	sleep 1
done

wp core install \
	--url=$DOMAIN_NAME \
	--title=$SITE_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email="$WP_ADMIN_EMAIL" \
	--path=/var/www/html \
	--allow-root

wp user create $WP_USER "$WP_USER_EMAIL" \
	--role=subscriber \
	--user_pass=$WP_USER_PASSWORD \
	--path=/var/www/html \
	--allow-root

exec /usr/sbin/php-fpm7.4 -F
