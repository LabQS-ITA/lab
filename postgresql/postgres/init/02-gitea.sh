#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER gitea;
    CREATE DATABASE gitea;
    GRANT ALL PRIVILEGES ON DATABASE gitea TO gitea;
    GRANT ALL ON SCHEMA public TO gitea;
    ALTER USER gitea SET timezone='America/Sao_Paulo';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "ALTER ROLE gitea WITH PASSWORD '$POSTGRES_PASSWORD';"
