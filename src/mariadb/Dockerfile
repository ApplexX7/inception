FROM alpine:3.20

# Update and install MariaDB and its dependencies in a single RUN statement to reduce layers
RUN apk update \
    && apk add --no-cache mariadb mariadb-client \
    && (getent group mysql || addgroup -S mysql) \
    && (getent passwd mysql || adduser -S mysql -G mysql) \
    && mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql \
    && mkdir -p /run/mysqld /var/log/maria \
    && chown mysql:mysql /run/mysqld /var/log/maria

# Copy custom initialization script and configuration file
COPY ./tools/mariadb.sh /mariadb.sh
COPY ./config/my.cnf /etc/mysql/my.cnf

# Ensure the configuration and script have proper permissions
RUN chmod 644 /etc/mysql/my.cnf \
    && chmod +x /mariadb.sh

EXPOSE 3306

# Set the entrypoint to run the MariaDB initialization script
ENTRYPOINT ["/mariadb.sh"]

