#!/bin/bash

kubectl delete --all pods
kubectl delete --all services
kubectl delete --all deployments
kubectl delete ingress --all

