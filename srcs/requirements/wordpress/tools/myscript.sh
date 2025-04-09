#!/bin/sh

if [ -f /var/www/html/wp-config.php ]; then
	echo "Wordpress aleady installed."
else

	sleep 20

	wp-cli.phar config create \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--allow-root \
		--path='/var/www/html'
	wp-cli.phar core install \
		--url=$DOMAIN_NAME \
		--title=$SITE_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root --path='/var/www/html'
	wp-cli.phar user create $WP_USER $WP_EMAIL \
		--role=author \
		--user_pass=$WP_PASSWORD \
		--allow-root \
		--path='/var/www/html'
fi

exec /usr/sbin/php-fpm7.4 -F
