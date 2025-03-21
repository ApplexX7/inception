#!/bin/bash

#!/bin/bash

# Download WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Set up WordPress directory
cd /var/www/wordpress
chmod -R 755 /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

# Download and Configure WordPress
wp core download --allow-root
wp core config --dbhost=mariadb:3306 --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_USER_PASSWORD}" --allow-root
wp core install --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN}" --admin_password="${WP_ADMIN_PASS}" \
    --admin_email="${WP_ADMIN_EMAIL}" --allow-root

# Create WordPress User
wp user create "${WP_USER_NAME}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role="${WP_USER_ROLE}" --allow-root

# Configure PHP-FPM
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

# Start PHP-FPM
mkdir -p /run/php
php-fpm7.4 -F

