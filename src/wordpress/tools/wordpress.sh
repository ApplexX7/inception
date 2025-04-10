#!/bin/sh

set -e

# Exporting environment variables (you can move these to Dockerfile or compose file later)
export DB_NAME=mariadb_database
export DB_USER=mohilali
export DB_USER_PASSWORD=hilali123
export DOMAIN_NAME=example.local
export WP_TITLE=inception
export WP_ADMIN=mohammed
export WP_ADMIN_PASS=mohammed123
export WP_ADMIN_EMAIL=test@gmail.com
export WP_USER_NAME=mohammedhilali
export WP_USER_PASSWORD=mohammedhilali123
export WP_USER_EMAIL=user@gmail.com
export WP_USER_ROLE=author

cd /var/www/wordpress

# Permissions
chmod -R 755 /var/www/wordpress
chown -R nobody:nobody /var/www/wordpress  # Alpine uses nobody:nobody; www-data may not exist

# Fix 1: Space required after [ and before ]
if [ ! -f /var/www/wordpress/wp-load.php ]; then
    echo "[INFO] Downloading WordPress..."
    wp core download --path=/var/www/wordpress --allow-root
fi      

# Fix 2: Typo in path: /va/ should be /var/
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "[INFO] Creating wp-config.php..."
    wp config create \
        --path=/var/www/wordpress \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_USER_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
fi      

# Install WordPress if not already installed
if ! wp core is-installed --path=/var/www/wordpress --allow-root; then
    echo "[INFO] Installing WordPress..."
    wp core install \
        --path=/var/www/wordpress \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    # Fix 3: Missing $ for WP_USER_EMAIL
    wp user create \
        "$WP_USER_NAME" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role="$WP_USER_ROLE" \
        --path=/var/www/wordpress \
        --allow-root
fi      

sed -i 's@listen = /run/php/php7.4-fpm.sock@listen = 0.0.0.0:9000@' /etc/php/7.4/fpm/pool.d/www.conf

# Start PHP-FPM
echo "[INFO] Starting PHP-FPM..."
exec php-fpm81 -F

