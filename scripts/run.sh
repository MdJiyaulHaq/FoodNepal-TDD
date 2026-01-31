#!/bin/sh

set -e

# Wait for database with timeout (Railway may take time to provide DB)
echo "Waiting for database at $DB_HOST:$DB_PORT..."
for i in $(seq 1 30); do
  if pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" 2>/dev/null; then
    echo "Database is ready!"
    break
  fi
  echo "Database not ready, retrying ($i/30)..."
  sleep 2
done

python manage.py collectstatic --noinput
python manage.py migrate

uwsgi --socket :9000 --workers 4 --master --enable-threads --module FoodNepal.wsgi