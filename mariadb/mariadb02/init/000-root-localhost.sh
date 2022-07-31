#!/bin/bash
set -e

sudo mysql <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
EOSQL