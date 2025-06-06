#!/bin/bash
PROJECT_NAME=$(grep PROJECT_NAME .env | cut -d '=' -f2)

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ PROJECT_NAME not found in .env"
  exit 1
fi

docker compose --env-file .env -p "$PROJECT_NAME" up
