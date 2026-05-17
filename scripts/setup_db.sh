#!/usr/bin/env bash

source .env
export PGPASSWORD=$DB_PASSWORD

set -e

DB_NAME="maritime_intelligence_db"
DB_USER="postgres"

echo "Creating database..."

psql -U $DB_USER -c "CREATE DATABASE $DB_NAME;" || echo "Database may already exist, continuing..."

echo "Running schema..."

psql -U $DB_USER -d $DB_NAME -f schema.sql

echo "Seeding lookup data..."

psql -U $DB_USER -d $DB_NAME -f seed_lookup_data.sql

echo "Setup complete!"