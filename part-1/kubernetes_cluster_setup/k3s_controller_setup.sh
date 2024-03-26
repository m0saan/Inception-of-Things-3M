#!/bin/bash

# Define the server IP address.
# The server IP address is passed as an argument and stored in the SERVER_IP variable.
SERVER_IP="$1"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
LOADING_SYMBOL="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

# Create directory for configurations (if not exist)
sudo mkdir -p /vagrant/.config

# Create a file to store the server token
sudo touch /vagrant/.config/k3s_server_token.txt

# Install K3s
# Set K3s server options
echo -e "${CYAN}${LOADING_SYMBOL} Installing K3s server...${NC}"

INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --flannel-iface=eth1"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$INSTALL_K3S_EXEC" sh - > /dev/null && \
    echo -e "${GREEN}K3s server installed successfully.${NC}"

# Copy server token to shared directory
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/.config/k3s_server_token.txt

# Install net-tools package for ifconfig command (optional)
echo -e "${CYAN}${LOADING_SYMBOL} Installing net-tools package...${NC}"
sudo apt-get install -y net-tools >/dev/null && \
    echo -e "${GREEN}Net-tools package installed.${NC}"

echo -e "${GREEN}K3s controller setup completed.${NC}"
