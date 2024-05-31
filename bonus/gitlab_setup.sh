#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


echo -e "${CYAN} Setting up Gitlab...${NC}"

sudo dnf update -y
sudo dnf install -y postfix curl
sudo ufw allow http
sudo ufw allow https
sudo dnf install -y gitlab-ce
sudo gitlab-ctl reconfigure
sudo cat /etc/gitlab/initial_root_password

# # Initialize Git repository``
# cd IoT-moboustt
# git init
# git add .
# git config --global user.email "moboustt@student.1337.ma"
# git config --global user.name "moboustt"
# git commit -m 'Initial commit'
# git remote add origin https://dev.gitlab.com/root/iot-moboustt.git
# git config --global http.sslverify false
# git push --set-upstream origin master
echo -e "${GREEN}Gitlab setup completed.${NC}"


echo -e "${GREEN}Setup completed.${NC}"