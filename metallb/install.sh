#!/bin/bash

set -e

helm repo add metallb https://metallb.github.io/metallb

helm repo update

helm upgrade \
  --install metallb metallb/metallb \
  --namespace metallb-system \
  --create-namespace

kubectl apply -f ipaddresspool.yaml

kubectl apply -f l2advertisement.yaml