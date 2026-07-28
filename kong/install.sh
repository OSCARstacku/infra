#!/bin/bash

set -e

helm repo add kong https://charts.konghq.com

helm repo update

helm install kong kong/kong \
    --namespace sdata \
    --create-namespace \
    -f values.yaml