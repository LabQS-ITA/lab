#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER labelstudio;
    CREATE DATABASE labelstudio;
    ALTER DATABASE labelstudio OWNER TO labelstudio;
    ALTER USER labelstudio SET timezone='America/Sao_Paulo';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE labelstudio WITH PASSWORD '$POSTGRES_PASSWORD';"
