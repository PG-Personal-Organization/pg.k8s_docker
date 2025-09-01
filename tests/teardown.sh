#!/usr/bin/env bash
set -e

echo "🗑️ Scaling down and cleaning environment..."

cd ..

# delete apps + infra + ingress
kubectl delete -R -f k8s/apps/ || true
kubectl delete -R -f k8s/infra/ || true
kubectl delete -f k8s/ingress.yaml || true

echo "✅ Environment deleted."
