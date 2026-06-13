#!/bin/sh

# Wait for database to be ready
echo "Waiting for PostgreSQL to be ready..."
for i in {1..30}; do
    if pg_isready -h $DB_HOST -U $DB_USERNAME 2>/dev/null; then
        echo "PostgreSQL is ready!"
        break
    fi
    echo "Attempt $i: PostgreSQL is not ready yet. Retrying in 2 seconds..."
    sleep 2
done

# Generate app key if needed
php artisan key:generate --force || true

# Run migrations
echo "Running migrations..."
php artisan migrate --force

# Start Laravel server
php artisan serve --host=0.0.0.0 --port=8000
