#!/bin/bash
SQL_FILE="$1"

if [ -z "$SQL_FILE" ]; then
  echo "❌ Usage: ./mysql-import.sh path/to/file.sql"
  exit 1
fi

if [ ! -f "$SQL_FILE" ]; then
  echo "❌ SQL file not found: $SQL_FILE"
  exit 1
fi

# Load .env values
export $(grep -E 'PROJECT_NAME|WORDPRESS_DB_' .env | xargs)

if [ -z "$PROJECT_NAME" ] || [ -z "$WORDPRESS_DB_NAME" ] || [ -z "$WORDPRESS_DB_USER" ] || [ -z "$WORDPRESS_DB_PASSWORD" ]; then
  echo "❌ Required environment variables not set in .env"
  exit 1
fi

CONTAINER_ID=$(docker compose --env-file .env -p "$PROJECT_NAME" ps -q db)

if [ -z "$CONTAINER_ID" ]; then
  echo "❌ Could not find a running 'db' container for project '$PROJECT_NAME'"
  exit 1
fi

BASENAME=$(basename "$SQL_FILE")

echo "📦 Copying $SQL_FILE to container..."
docker cp "$SQL_FILE" "$CONTAINER_ID:/tmp/$BASENAME"

echo "🧠 Importing into DB..."
docker compose --env-file .env -p "$PROJECT_NAME" exec db \
  sh -c "mysql -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME < /tmp/$BASENAME"

echo "✅ Import complete."