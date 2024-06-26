#!/bin/bash
GR='\033[0;32m'
NC='\033[0m' # No Color
CYAN='\033[0;36m'

echo "${CYAN}==> Creating k3d cluster...${NC}"
# `-p "8888:30080"`: This flag is used to map ports from the host machine to the Kubernetes cluster.
# It's specified in the format `<host-port>:<container-port>`.
# Here, it's mapping port 8888 on the host machine to port 30080 in the Kubernetes cluster.
# This means that any traffic sent to port 8888 on the host machine will be forwarded to port 30080 within the Kubernetes cluster.

sudo k3d cluster create IoT -p "8888:30080"
sleep 5;

echo "${CYAN}==> Creating argocd namespace...${NC}"
# This will create a new namespace, argocd, where Argo CD services and application resources will live.
sudo kubectl create namespace argocd
sleep 5;

echo "${CYAN}==> Installing ArgoCD in the k3d cluster...${NC}"
# This command installs Argo CD in the k3d cluster.
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl wait -n argocd --for=condition=Ready pods --all --timeout=60s

echo "${CYAN}==> Getting ArgoCD password...${NC}"
# This command retrieves the password for the Argo CD admin user.
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

sudo kubectl apply -f /vagrant/deployments/application.yaml
# sudo kubectl wait deployment --namespace default --for=condition=available --timeout=120s --all

sudo kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 5555:443 &


# sudo lsof -i -P -n | grep 8080
