#!/bin/sh

mkdir -p /run/php /var/www/html

if [ ! -f /var/www/html/.installed ]; then
	cp /usr/bin/php82 /usr/bin/php
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp-cli.phar
	cd /var/www/html
	echo "downloading wordpress"
	wp-cli.phar core download
	echo "creating wordpress config"
	wp-cli.phar config create --dbname=$MARIADB_DBNAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb
	echo "installing wordpress config"
	wp-cli.phar core install --url=$DOMAIN_NAME --title=Inception --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
	wp-cli.phar user create $WP_USER $WP_EMAIL --role=subscriber --user_pass=$WP_PASSWORD --allow-root
	wp-cli.phar theme install twentytwentythree --activate --allow-root
	wp-cli.phar post delete $(wp-cli.phar post list --format=ids --allow-root) --allow-root
	wp-cli.phar post create --post_type=post --post_title="This is a post" --post_content="... and its content" --post_status=publish --allow-root
	touch /var/www/html/.installed
else
	echo "wordpress is already installed, skipping installation.."
fi

echo "starting php fpm"
exec php-fpm82 -F -R
