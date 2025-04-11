#!/bin/sh


# Exporting environment variables (move to Dockerfile or compose file later)
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

# Set Permissions
chmod -R 755 /var/www/wordpress
chown -R nobody:nobody /var/www/wordpress

# Download WordPress if not already downloaded
if [ ! -f /var/www/wordpress/wp-load.php ]; then
    echo "[INFO] Downloading WordPress..."
    wp core download --path=/var/www/wordpress --allow-root
fi

 #Create wp-config.php if not already created
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

# Install WordPress if not installed already
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

    echo "[INFO] Creating user..."
    wp user create \
        "$WP_USER_NAME" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role="$WP_USER_ROLE" \
        --path=/var/www/wordpress \
        --allow-root
fi

# Modify PHP-FPM Configuration to Listen on Port 9000
sed -i 's@listen = /run/php/php8.3-fpm.sock@listen = 0.0.0.0:9000@' /etc/php83/php-fpm.d/www.conf

# Start PHP-FPM
echo "[INFO] Starting PHP-FPM..."
exec php-fpm83 -F

