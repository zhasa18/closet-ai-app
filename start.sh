#!/usr/bin/env bash

set -euo pipefail

if [ ! -f .env ]; then
  echo ".env not found in $(pwd)"; exit 1
fi

echo "Bringing containers down (remove orphans)..."
docker compose down --remove-orphans

echo "Building and starting containers..."
docker compose up -d --build

# Wait for Postgres to be ready (max ~60s)
echo "Waiting for Postgres to become ready..."
for i in $(seq 1 60); do
  if docker compose exec -T db pg_isready -U "${POSTGRES_USER:-postgres}" -d "${POSTGRES_DB:-app_development}" >/dev/null 2>&1; then
    echo "Postgres is ready."
    break
  fi
  sleep 1
done

# Ensure RN container has correct ownership for mounted files (avoids yarn permission errors)
if docker compose ps -q rn >/dev/null 2>&1; then
  echo "Fixing ownership inside RN container..."
  docker compose exec --user root rn sh -c "chown -R ${HOST_UID:-1000}:${HOST_GID:-1000} /app || true"
fi

echo "Tailing logs for api, rn and ollama (ctrl-c to exit)..."
docker compose logs -f api rn ollama