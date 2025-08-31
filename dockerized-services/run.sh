#!/bin/bash
set -e

echo "🚀 Starting all services from compose-env.yml..."
docker compose -f compose-env.yml up -d

echo "✅ All services are up! Use 'docker compose -f compose-env.yml ps' to check status."
