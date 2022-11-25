#!/bin/bash
set -e

mysql --password="$MARIADB_ROOT_PASSWORD" <<-EOSQL
    grant all privileges on *.* to 'root'@'172.16.0.0/255.255.0.0' identified by password '$MARIADB_PASSWORD' with grant option;
EOSQL