#!/bin/sh

# Start MySQL server in safe mode (this will restart MySQL)
mysqld --user=mysql &

MYSQL_PID=$!
# Wait a bit to allow MySQL to start (optional)
sleep 5

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create the user if not exists
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@localhost IDENTIFIED BY '$DB_USER_PASSWORD';"

# Grant privileges to the new user
mysql -u root  -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@localhost IDENTIFIED BY '$DB_USER_PASSWORD';"

# Flush privileges to ensure changes take effect
mysql -u root -e "FLUSH PRIVILEGES;"

# Optionally, restart MySQL server after granting permissions (if needed)
kill $MYSQL_PID

exec mysqld --user=mysql --port=3306
