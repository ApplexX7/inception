#!/bin/sh

set -e

export DB_USER=mohilali
export DB_USER_PASSWORD=password123
export DB_NAME=data_name

# Start MySQL server in safe mode (this will restart MySQL)
mariadbd --user=mysql &
MYSQL_PID="$!"

# Wait a bit to allow MySQL to start (optional)
until mysql -u root --password="$MD_ROOT_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MySQL to start..."
    sleep 5
done

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create the user if not exists
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"

# Grant privileges to the new user
mysql -u root  -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"

# Flush privileges to ensure changes take effect
mysql -u root -e "FLUSH PRIVILEGES;"

# Optionally, restart MySQL server after granting permissions (if needed)
kill -s TERM $MYSQL_PID
wait "$MYSQL_PID"

exec mariadbd --user=mysql
