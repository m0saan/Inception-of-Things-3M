#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


echo -e "${CYAN} Installing Docker...${NC}"
sudo apt-get update -y
sudo curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo -e "${GREEN}$ Done installing docker.${NC}"

echo " ${CYAN} Installing kubectl...${NC}"
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/arm64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo kubectl version --client
echo " ${GREEN} Done installing kubectl.${NC}"


echo -e "${CYAN} Installing K3D...${NC}"
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo -e "${GREEN}$ Done installing K3D.${NC}"

sudo sh /vagrant/kubernetes_cluster_setup/setup_cd.sh


## install Helm

# sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# ## create namespace for gitlab

# sudo kubectl create namespace gitlab

# sudo helm repo add gitlab https://charts.gitlab.io/
# sudo helm repo update

echo -e "${GREEN}Setup completed.${NC}"
