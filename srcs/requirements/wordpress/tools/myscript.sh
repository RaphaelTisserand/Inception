#!/bin/sh

cd 

sleep 20

if [ -f /var/www/html/wp-config.php ]; then
	echo "Wordpress aleady installed."
else

	cd /var/www/html

	wp core download \
		--allow-root
	wp config create \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb \
		--allow-root \
		--skip-check
	wp core install \
		--url=$DOMAIN_NAME \
		--title=$SITE_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root
	wp user create $WP_USER $WP_EMAIL \
		--role=suscriber \
		--user_pass=$WP_PASSWORD \
		--allow-root
fi

exec /usr/sbin/php-fpm7.4 -F
