source .env
export PGPASSWORD=$DB_PASSWORD

psql -U postgres -d maritime_intelligence_db