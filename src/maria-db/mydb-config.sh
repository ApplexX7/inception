#!/bin/bash

service mariadb start

sleep 5

mariadb -u $DB_USER -p$DB_PASSWORD -h $DB_HOST -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

if [ $? -eq 0 ]; then
	echo "Database '$DB_NAME' created successfuly."
else
	echo "Failed to create databse '$DB_NAME'"

