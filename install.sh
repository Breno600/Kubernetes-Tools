#!/bin/bash

curl -sfL https://get.k3s.io/ | INSTALL_K3S_VERSION=v1.21.5+k3s2 sh -s - --no-deploy=traefik

kubectl create namespace cert-manager
kubectl create ns ingress-nginx

kubectl apply --validate=false -f cert-manager-1.0.4.yaml
kubectl -n ingress-nginx apply -f ingress-controller-nginx.yaml
kubectl apply -f cert-issuer-nginx-ingress.yaml