#!/bin/bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "template1" <<-EOSQL
    CREATE DATABASE chaos_testing OWNER $POSTGRES_USER;
EOSQL
