FROM alpine:3.20

RUN apk add --no-cache mariadb mariadb-client 

#Create MySQL runtime directory and set ownership
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld


#create data directory, set ownership and permissions
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 700 /var/lib/mysql

COPY ./config/my.cnf /etc/my.cnf.d/mariadb-server.cnf

#initialize
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./tools/mariadb.sh /
RUN chmod +x /mariadb.sh

ENTRYPOINT ["/mariadb.sh"]
