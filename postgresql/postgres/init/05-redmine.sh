#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER redmine;
    CREATE DATABASE redmine;
    ALTER DATABASE redmine OWNER TO redmine;
    ALTER USER redmine SET timezone='America/Sao_Paulo';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE redmine WITH PASSWORD '$POSTGRES_PASSWORD';"
