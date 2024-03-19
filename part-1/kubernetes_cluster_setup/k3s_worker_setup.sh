#!/bin/bash

# Server IP address passed from command line argument
SERVER_IP=$1

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
LOADING_SYMBOL="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

echo -e "${CYAN}Starting K3s Agent installation...${NC}"

# Set server details
SERVER_PORT=6443
SERVER_URL="https://${SERVER_IP}:${SERVER_PORT}"

# K3s token file location
K3S_TOKEN_FILE="/vagrant/.config/k3s_server_token.txt"

# Install K3s Agent
echo -e "${CYAN}${LOADING_SYMBOL} Installing K3s Agent...${NC}"
curl -sfL https://get.k3s.io | K3S_URL=${SERVER_URL} K3S_TOKEN_FILE=${K3S_TOKEN_FILE} INSTALL_K3S_EXEC="--flannel-iface=eth1" sh - > /dev/null && \
    echo -e "${GREEN}K3s Agent is Running.${NC}"

# Install net-tools package (optional)
echo -e "${CYAN}${LOADING_SYMBOL} Installing net-tools package...${NC}"
sudo apt install -y net-tools > /dev/null && \
    echo -e "${GREEN}Net-tools package installed.${NC}"

# Clean up
echo -e "${CYAN}Cleaning up...${NC}"
sudo rm -rf /vagrant/.config

echo -e "${GREEN}K3s Agent setup completed.${NC}"
