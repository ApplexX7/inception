#!/bin/sh

DB_USER_PASSWORD=$(cat /run/secrets/db_user_password)

set -e

echo "starting Mariadb ..."
mysqld --user=mysql &

until [ -S /run/mysqld/mysqld.sock ]; do
	echo "Mariadb is not running yet"
	sleep 2
done

echo "Maraidb started, creating database and user ..."

mysql -u root -e "
CREATE DATABASE IF NOT EXISTS $DB_NAME;

CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';

GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';

FLUSH PRIVILEGES;"

mariadb-admin --user=root shutdown

echo "Mariadb setup completed. Running in the forground."

exec mysqld --user=mysql --datadir=/var/lib/mysql
