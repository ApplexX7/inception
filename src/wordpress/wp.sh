#!/bin/bash

curl -O curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress

chmod -R 755 /var/www/wordpress

chown -R www-data:www-data /var/www/wordpress

wp core download --allow-root

wp core config --dbhost=mariadb:3306 --dbname="$DB_NAME" --dbuser="DB_USER" --dbpass="DB_ROOT_PASSWORD" --allow-root

wp core install --url="$DOMAINE_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMINE_PASS" \ 
	--admin_email="$WP_ADMINE_EMAIL" --allow-root

wp user create "$WP_USER_NAME" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role="$WP_USER_ROLE" --allow-root

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.config

mkdir -p /run/php

/usr/bin/php-fpm7.4 -F
