#!/bin/bash
docker-compose --env-file .env -p $(grep PROJECT_NAME .env | cut -d '=' -f2) up