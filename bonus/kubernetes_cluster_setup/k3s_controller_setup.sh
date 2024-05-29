#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


# echo -e "${CYAN} Installing Docker...${NC}"
# sudo apt-get update -y
# sudo curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
# sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# echo -e "${GREEN}$ Done installing docker.${NC}"

# echo " ${CYAN} Installing kubectl...${NC}"
# sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/arm64/kubectl
# sudo chmod +x ./kubectl
# sudo mv ./kubectl /usr/local/bin/kubectl
# sudo kubectl version --client
# echo " ${GREEN} Done installing kubectl.${NC}"


# echo -e "${CYAN} Installing K3D...${NC}"
# wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
# echo -e "${GREEN}$ Done installing K3D.${NC}"


echo -e "${CYAN} Setting up Gitlab...${NC}"

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y ca-certificates curl openssh-server tzdata perl
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo EXTERNAL_URL="https://localhost" apt install gitlab-ce -y
sudo echo "y" | sudo ufw enable
sudo ufw allow http
sudo ufw allow https
sudo ufw allow OpenSSH
sudo gitlab-ctl reconfigure

# sudo apt update -y && apt upgrade -y
# sudo apt install curl git -y
# sudo curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
# sudo sed -i 's/bullseye/buster/g' /etc/apt/sources.list.d/gitlab_gitlab-ce.list
# sudo apt update -y
# sudo export GITLAB_ROOT_PASSWORD='m0saan123'
# sudo apt install gitlab-ce -y
# sudo gitlab-ctl reconfigure


# # # # Initialize Git repository
# cp -r /vagrant/IoT-moboustt . && cd IoT-moboustt
# sudo git init
# sudo git add .
# sudo git config --global --add safe.directory /home/vagrant/IoT-moboustt
# sudo git config --global user.email "moboustt@student.1337.ma"
# sudo git config --global user.name "moboustt"
# sudo git commit -m 'Initial commit'
# sudo git remote add origin http://gitlab.example.com/root/iot-moboustt.git
# sudo git config --global http.sslverify false
# sudo git push --set-upstream origin master
# echo -e "${GREEN}Gitlab setup completed.${NC}"

# sudo echo "y" | sudo ufw enable
# sudo ufw allow http
# sudo ufw allow https
# sudo ufw allow OpenSSH

# sudo apt update -y
# sudo curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
# sudo export GITLAB_ROOT_PASSWORD='m0saan123'
# sudo apt install gitlab-ce -y
# sudo gitlab-ctl reconfigure
echo -e "${GREEN}Setup completed.${NC}"
