#!/bin/bash
set -e

mysql --password="$MARIADB_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE keystone;
    GRANT ALL PRIVILEGES ON  keystone.* TO 'keystone'@'localhost' IDENTIFIED BY '$MARIADB_PASSWORD';
    GRANT ALL PRIVILEGES ON  keystone.* TO 'keystone'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
EOSQL
