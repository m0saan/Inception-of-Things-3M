#!/bin/bash

app1_deployment="/vagrant/kubernetes_cluster_setup/app1.yaml"
app2_deployment="/vagrant/kubernetes_cluster_setup/app2.yaml"
app3_deployment="/vagrant/kubernetes_cluster_setup/app3.yaml"
ingress_app1="/vagrant/kubernetes_cluster_setup/app-ingress.yaml"

echo "Deploying the applications..."
sudo kubectl apply -f $app1_deployment
sudo kubectl apply -f $app2_deployment
sudo kubectl apply -f $app3_deployment

echo "Deploying the ingress..."
sudo kubectl apply -f $ingress_app1

echo "Waiting for the applications to be ready..."
sudo kubectl wait --for=condition=ready pod --all --timeout=300s

echo "Checking the status of the applications..."
sudo kubectl get pods -o wide

echo "Checking the status of the ingress..."
sudo kubectl get ingress -o wide