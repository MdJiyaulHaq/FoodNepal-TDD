#!/bin/sh

set -e

# Only wait for PostgreSQL on local development (DEBUG=1)
# On Railway with DEBUG=0, we use SQLite so no database check needed
if [ "$DEBUG" = "1" ]; then
  echo "Waiting for PostgreSQL at $DB_HOST:$DB_PORT..."
  for i in $(seq 1 30); do
    if pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" 2>/dev/null; then
      echo "PostgreSQL is ready!"
      break
    fi
    echo "Database not ready, retrying ($i/30)..."
    sleep 2
  done
else
  echo "Using SQLite (no database check needed)"
fi

python manage.py collectstatic --noinput
python manage.py migrate

uwsgi --socket :9000 --workers 4 --master --enable-threads --module FoodNepal.wsgi