#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER netbox;
    CREATE DATABASE netbox;
    GRANT ALL PRIVILEGES ON DATABASE netbox TO netbox;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE netbox WITH PASSWORD '$POSTGRES_PASSWORD';"