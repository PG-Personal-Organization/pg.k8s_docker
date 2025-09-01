#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping microservices environment..."

cd ..

# --- Step 1. Apply infra ---
echo "📦 Deploying infrastructure (Postgres, Mongo, Kafka, MinIO)..."
kubectl apply -R -f k8s/infra/

# --- Step 2. Wait for infra to become ready ---
echo "⏳ Waiting for infra pods to be ready..."
kubectl wait --for=condition=available --timeout=180s deployment/postgres || true
kubectl wait --for=condition=available --timeout=180s deployment/mongo || true
kubectl wait --for=condition=available --timeout=180s deployment/kafka || true
kubectl wait --for=condition=available --timeout=180s deployment/minio || true

# --- Step 3. Apply apps ---
echo "📦 Deploying microservices (api-gateway, accounts, context-auth, payments)..."
kubectl apply -R -f k8s/apps/

# --- Step 4. Apply ingress ---
echo "🌐 Deploying ingress..."
kubectl apply -f k8s/ingress.yaml

# --- Step 5. Wait for apps ---
echo "⏳ Waiting for apps pods to be ready..."
kubectl wait --for=condition=available --timeout=180s deployment/api-gateway || true
kubectl wait --for=condition=available --timeout=180s deployment/accounts || true
kubectl wait --for=condition=available --timeout=180s deployment/context-auth || true
kubectl wait --for=condition=available --timeout=180s deployment/payments || true

echo "✅ Environment ready!"
echo "👉 Access services:"
echo "   - API Gateway:    http://api.local"
echo "   - Accounts:       http://accounts.local"
echo "   - Context-Auth:   http://auth.local"
echo "   - Payments:       http://payments.local"
echo "   - pgAdmin:        http://pgadmin.local"
echo "   - Mongo Express:  http://mongo.local"
echo "   - AKHQ:           http://akhq.local"
echo "   - MinIO:          http://minio.local"
echo "   - Prometheus:     http://prometheus.local"
echo "   - Grafana:        http://grafana.local"

sh tests/init_data.sh
