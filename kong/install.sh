#!/bin/bash

set -e

helm repo add kong https://charts.konghq.com

helm repo update

helm upgrade \
  --install kong kong/kong \
  --namespace sdata \
  --create-namespace \
  -f values.yaml \
  --set image.repository=oscarstacku/kong-grpc \
  --set image.tag=3.9.3

kubectl rollout status deployment/kong -n sdata