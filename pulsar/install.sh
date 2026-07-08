#!/bin/bash

set -e

helm repo add apache https://pulsar.apache.org/charts

helm repo update

helm upgrade \
    --install pulsar \
    apache/pulsar \
    --namespace sdata \
    --create-namespace \
    -f values.yaml