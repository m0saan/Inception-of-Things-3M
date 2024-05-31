#!/bin/bash
GR='\033[0;32m'
NC='\033[0m' # No Color
CYAN='\033[0;36m'

create_k3d_cluster() {
    echo "${CYAN}==> Creating k3d cluster...${NC}"
    sudo k3d cluster create IoT -p "8888:30080"
    sleep 5
}

create_argocd_namespace() {
    echo "${CYAN}==> Creating argocd namespace...${NC}"
    sudo kubectl create namespace argocd
    sleep 5
}

install_argocd() {
    echo "${CYAN}==> Installing ArgoCD in the k3d cluster...${NC}"
    sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    sudo kubectl wait -n argocd --for=condition=Ready pods --all --timeout=60s
}

get_argocd_password() {
    echo "${CYAN}==> Getting ArgoCD password...${NC}"
    sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
}

apply_application_yaml() {
    sudo kubectl apply -f /vagrant/deployments/application.yaml
    sudo kubectl wait deployment --namespace default --for=condition=available --timeout=120s --all
}

port_forward_argocd_server() {
    sudo kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443 &
}

create_k3d_cluster
create_argocd_namespace
install_argocd
get_argocd_password
apply_application_yaml
port_forward_argocd_server
