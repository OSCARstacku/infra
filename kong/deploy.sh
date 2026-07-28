#!/bin/bash

set -e

ROOT=$(cd "$(dirname "$0")"/../.. && pwd)

echo "Reconstruyendo imagen..."

docker build \
    -t kong-grpc:3.9.3 \
    -f "$ROOT/infra/kong/Dockerfile" \
    "$ROOT"

echo "Importando imagen..."

docker save kong-grpc:3.9.3 \
| sudo k3s ctr images import -

echo "Actualizando Helm..."

helm upgrade kong kong/kong \
    -n sdata \
    -f "$ROOT/infra/kong/values.yaml"

kubectl rollout restart deployment kong -n sdata

kubectl rollout status deployment kong -n sdata

echo "Deploy terminado."