#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER redmine;
    CREATE DATABASE redmine;
    GRANT ALL PRIVILEGES ON DATABASE redmine TO redmine;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE semaphore WITH PASSWORD '$POSTGRES_PASSWORD';"