#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER semaphore;
    CREATE DATABASE semaphore;
    ALTER DATABASE semaphore OWNER TO semaphore;
    ALTER USER semaphore SET timezone='America/Sao_Paulo';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE semaphore WITH PASSWORD '$POSTGRES_PASSWORD';"
