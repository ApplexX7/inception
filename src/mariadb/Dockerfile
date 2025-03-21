FROM alpine:3.20


RUN apk add --no-cache mariadb mariadb-client 

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 700 /var/lib/mysql

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./mydb-config.sh /mydb-config.sh


COPY ./my.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x /mydb-config.sh

EXPOSE 3306

ENTRYPOINT ["/mydb-config.sh"]
