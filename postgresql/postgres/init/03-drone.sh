#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER drone;
    CREATE DATABASE drone;
    ALTER DATABASE drone OWNER TO drone;
    ALTER USER drone SET timezone='America/Sao_Paulo';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE drone WITH PASSWORD '$POSTGRES_PASSWORD';"
