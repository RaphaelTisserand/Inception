#!/bin/sh

mkdir -p /run/php var/run/php /var/www/html

if [ -f /var/www/html/.installed ]; then
	echo "Wordpress aleady installed."
else
	cd /var/www/html
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp-cli.phar
	wp-cli.phar core download --allow-root
	wp-cli.phar config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=3306 --allow-root

	until wp db check --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --path=/var/www/html --quiet --allow-root; do
	echo "Waiting for MySQL..."
	sleep 1
	done

	wp-cli.phar core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
	wp-cli.phar user create $WP_USER $WP_EMAIL --role=subscriber --user_pass=$WP_PASSWORD --allow-root
	wp theme install twentyfourteen --activate --allow-root
	wp post delete $(wp post list --format=ids --allow-root) --allow-root
	wp post create --post_type=post --post_title="This is a post" --post_content="... and its content :)" --post_status=publish --allow-root
	touch /var/www/html/.installed
fi

chown -R www-data:www-data /var/www/inception/
chmod -R 755 /var/www*

exec /usr/sbin/php-fpm7.4 -F
