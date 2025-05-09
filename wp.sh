#!/bin/bash
# Get the project name from .env
PROJECT_NAME=$(grep PROJECT_NAME .env | cut -d '=' -f2)

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ PROJECT_NAME not found in .env"
  exit 1
fi

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "${PROJECT_NAME}-wordpress"; then
  echo "❌ WordPress container is not running. Start it with ./start.sh"
  exit 1
fi

# Forward the command to WP-CLI inside the container
docker compose --env-file .env -p "$PROJECT_NAME" exec wordpress wp "$@"