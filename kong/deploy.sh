#!/bin/bash

set -e

echo "Actualizando Kong..."

helm upgrade \
  --install kong kong/kong \
  --namespace sdata \
  --create-namespace \
  -f values.yaml

echo "Esperando rollout..."

kubectl rollout restart deployment kong -n sdata

kubectl rollout status deployment kong -n sdata

echo "Listo."