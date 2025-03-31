#!/bin/sh

sleep 10

mkdir -p /run/php /var/www/html

if [ -f /var/www/html/.installed ]; then
	echo "Wordpress aleady installed."
else
	cp /usr/bin/php /usr/bin/php
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp-cli.phar
	cd /var/www/html
	wp-cli.phar core download --allow-root
	wp-cli.phar config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=3306 --allow-root
	wp-cli.phar core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
	wp-cli.phar user create $WP_USER $WP_EMAIL --role=subscriber --user_pass=$WP_PASSWORD --allow-root
	touch /var/www/html/.installed
fi

exec php-fpm -F -R
