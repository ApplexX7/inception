#FROM alpine:3.20
#
## Update and install MariaDB and its dependencies in a single RUN statement to reduce layers
#RUN apk update \
#    && apk add --no-cache mariadb mariadb-client \
#    && (getent group mysql || addgroup -S mysql) \
#    && (getent passwd mysql || adduser -S mysql -G mysql) \
#    && mkdir -p /run/mysqld /var/log/maria \
#    && chown mysql:mysql /run/mysqld /var/log/maria
#
## Copy custom initialization script and configuration file
#COPY ./tools/mariadb.sh /mariadb.sh
#COPY ./config/my.cnf /etc/my.cnf.d/mariadb-server.cnf
#
## Ensure the configuration and script have proper permissions
#RUN chmod 644 /etc/mysql/my.cnf \
#    && chmod +x /mariadb.sh
#
#RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
#
#EXPOSE 3306
#
## Set the entrypoint to run the MariaDB initialization script
#ENTRYPOINT ["/mariadb.sh"]



FROM alpine:3.20

RUN apk add --no-cache mariadb mariadb-client 

#Create MySQL runtime directory and set ownership
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld


#reate data directory, set ownership and permissions
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 700 /var/lib/mysql

COPY ./config/my.cnf /etc/my.cnf.d/mariadb-server.cnf

#nitialize
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./tools/mariadb.sh /
RUN chmod +x /mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb.sh"]
