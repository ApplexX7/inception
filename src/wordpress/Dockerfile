FROM alpine:3.20

# Install PHP 8.3 FPM and required extensions
RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-xml \
    php83-phar \
    php83-intl \
    php83-dom \
    php83-ctype \
    php83-session \
    php83-mbstring \
    php83-gd \
    curl \
    unzip \
    mariadb-client \
    shadow \
    su-exec

# Install WP-CLI (WordPress CLI tool)
RUN curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN echo "memory_limit = "
# Create WordPress directory
RUN mkdir -p /var/www/wordpress

# Set permissions for WordPress files
RUN chown -R nobody:nobody /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

# Copy custom WordPress install script
COPY ./tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

# Optional: copy your custom www.conf for PHP-FPM config
# COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

# Expose PHP-FPM port
EXPOSE 9000

# Launch entrypoint script (install WordPress or start php-fpm)
ENTRYPOINT ["/wordpress.sh"]

