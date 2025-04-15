#!/bin/sh

sleep 10

if [ -f /var/www/html/wp-config.php ]; then
	echo "Wordpress aleady installed."
else

	cd /var/www/html

	wp core download --allow-root
	rm -f /var/www/html/wp-config.php
	wp config create \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb \
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
	wp theme install twentyfourteen \
		--activate \
		--allow-root
	wp post delete $(wp post list --format=ids --allow-root) \
		--allow-root
	wp post create \
		--post_type=post \
		--post_title="This is a post" \
		--post_content="... and its content :)" \
		--post_status=publish \
		--allow-root
fi

exec /usr/sbin/php-fpm7.4 -F
