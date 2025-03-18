#!/bin/bash

mysqladmin -u root -p shutdown

mysql -u root -p

mysql

mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
