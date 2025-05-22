#!/bin/sh

set -e

DB_USER_PASSWORD=$(cat /run/secrets/db_user_password)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)


cd /var/www/html

# Set Permissions
chmod -R 755 /var/www/html
chown -R nobody:nobody /var/www/html

# Download WordPress if not already downloaded
if [ ! -d /var/www/html/wp-content ]; then
    echo "[INFO] Downloading WordPress..."
    wp core download --path=/var/www/html --allow-root
fi

# Create wp-config.php if not already created
#if [ ! -f /var/www/html/wp-config.php ]; then
   # echo "[INFO] Creating wp-config.php..."
    #wp config create \
      #  --path=/var/www/html \
     #   --dbname="$DB_NAME" \
    #    --dbuser="$DB_USER" \
   #     --dbpass="$DB_USER_PASSWORD" \
  #      --dbhost="mariadb:3306" \
 #       --allow-root

    # Secure the wp-config.php with salts
    #wp config shuffle-salts --path=/var/www/html --allow-root
#fi

# Install WordPress if not installed already
if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "[INFO] Installing WordPress..."
    wp core install \
        --path=/var/www/html \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASS \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    echo "[INFO] Creating user..."
    wp user create \
       	$WP_USER_NAME $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=$WP_USER_ROLE \
        --path=/var/www/html \
        --allow-root
    echo "[INFO] installing redis serice plugin.."
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
fi

# Modify PHP-FPM Configuration to Listen on Port 9000
sed -i 's@^listen = .*@listen = 0.0.0.0:9000@' /etc/php83/php-fpm.d/www.conf

# Start PHP-FPM
echo "[INFO] Starting PHP-FPM..."
exec php-fpm83 -F

