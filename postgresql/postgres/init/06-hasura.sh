#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER hasura;
    CREATE DATABASE hasura;
    GRANT ALL PRIVILEGES ON DATABASE hasura TO hasura;
    GRANT ALL ON SCHEMA public TO hasura;
    ALTER USER hasura SET timezone='America/Sao_Paulo';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE hasura WITH PASSWORD '$POSTGRES_PASSWORD';"
