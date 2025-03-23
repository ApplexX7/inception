#!/bin/bash

# Environment variables for WordPress configuration
export DB_USER=mohilali
export DB_USER_PASSWORD=password123
export DB_NAME=data_name

export DOMAIN_NAME=https://localhost
export WP_ADMIN=mohammedali
export WP_ADMIN_PASS=mohilali123
export WP_TITLE=42_inception
export WP_ADMIN_EMAIL=mr.mhdhilali@email.com

export WP_USER_NAME=hilali
export WP_USER_EMAIL=apx.hilali@email.com
export WP_USER_PASSWORD=Hilali1112004
export WP_USER_ROLE=author

# Function to wait for MariaDB to be ready

# Download WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


sleep 5

# Set up WordPress directory
cd /var/www/wordpress
chmod -R 755 /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

# Download and Configure WordPress
wp core download --allow-root

# Create wp-config.php with database settings
wp core config --dbhost=mariadb:3306 --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_USER_PASSWORD}" --allow-root

# Install WordPress
wp core install --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN}" --admin_password="${WP_ADMIN_PASS}" \
    --admin_email="${WP_ADMIN_EMAIL}" --allow-root

# Create WordPress User
wp user create "${WP_USER_NAME}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role="${WP_USER_ROLE}" --allow-root

# Configure PHP-FPM for compatibility (adjust as per your PHP version)
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

# Start PHP-FPM
mkdir -p /run/php
php-fpm7.4 -F

