#!/bin/bash

# Define the server IP address.
# The server IP address is passed as an argument and stored in the SERVER_IP variable.
SERVER_IP="$1"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
LOADING_SYMBOL="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

# Install K3s
# Set K3s server options
echo -e "${CYAN}${LOADING_SYMBOL} Installing K3s server...${NC}"

INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --flannel-iface=eth1 --write-kubeconfig-mode 644"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$INSTALL_K3S_EXEC" sh - > /dev/null && \
    echo -e "${GREEN}K3s server installed successfully.${NC}"

# Install net-tools package for ifconfig command (optional)
echo -e "${CYAN}${LOADING_SYMBOL} Installing net-tools package...${NC}"
sudo apt-get install -y net-tools >/dev/null && \
    echo -e "${GREEN}Net-tools package installed.${NC}"

# sudo apt update -y
# sudo apt install nginx -y

echo -e "${CYAN}${LOADING_SYMBOL} Setting up Kubernetes cluster...${NC}"
sudo sh /vagrant/kubernetes_cluster_setup/create_apps.sh
echo -e "${GREEN}Kubernetes cluster setup completed.${NC}"

echo -e "${GREEN}K3s controller setup completed.${NC}"
