#!/bin/bash

set -e

ROOT=$(cd "$(dirname "$0")"/../.. && pwd)

echo "Construyendo imagen personalizada..."

docker build \
    -t kong-grpc:3.9.3 \
    -f "$ROOT/infra/kong/Dockerfile" \
    "$ROOT"

echo "Importando imagen a k3s..."

docker save kong-grpc:3.9.3 \
| sudo k3s ctr images import -

echo "Instalando Kong..."

helm repo add kong https://charts.konghq.com

helm repo update

helm upgrade \
    --install kong kong/kong \
    -n sdata \
    --create-namespace \
    -f "$ROOT/infra/kong/values.yaml"

kubectl rollout status deployment/kong -n sdata

echo "Kong instalado."