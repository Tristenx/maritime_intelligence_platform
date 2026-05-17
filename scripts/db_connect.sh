#!/usr/bin/env bash

source .env
export PGPASSWORD=$DB_PASSWORD

psql -U postgres -d maritime_intelligence_db