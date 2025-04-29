FROM alpine:3.20

# Install PHP and necessary extensions
RUN apk add --no-cache \
    php83 \
    php83-session \
    php83-mysqli \
    php83-pdo_mysql \
    curl

# Set up Adminer
RUN mkdir -p /var/www/adminer && \
    curl -L -o /var/www/adminer/adminer.php https://www.adminer.org/latest.php

# Set correct permissions for the files
RUN chown -R nobody:nobody /var/www/adminer

# Run as 'nobody' user for security
USER nobody

# Expose port 8080 for the Adminer web interface
EXPOSE 8080

# Start the PHP built-in server
ENTRYPOINT ["php83", "-S", "0.0.0.0:8080", "/var/www/adminer/adminer.php"]

