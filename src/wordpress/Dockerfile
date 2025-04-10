FROM php:8-cli-alpine3.20

# Install system dependencies and PHP extensions
RUN apk update && apk add --no-cache \
    mariadb-client \
    curl \
    unzip \
    libpng-dev \
    libjpeg-turbo-dev \
    libxml2-dev \
    && docker-php-ext-install \
    mysqli \
    opcache \
    json \
    mbstring \
    zlib \
    gd \
    dom \
    iconv

# Install WP-CLI (WordPress Command Line Interface)
RUN curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Create the WordPress directory and set appropriate permissions
RUN mkdir -p /var/www/wordpress && chmod -R 755 /var/www/wordpress

# Copy the WordPress installation script
COPY ./tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

# Set proper permissions for the WordPress directory
RUN chown -R nobody:nobody /var/www/wordpress

# Expose PHP-FPM port (usually port 9000 for PHP-FPM)
EXPOSE 9000

# Set the entrypoint to the WordPress installation script
ENTRYPOINT ["/wordpress.sh"]

