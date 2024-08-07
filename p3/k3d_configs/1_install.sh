#!/bin/bash

sudo apt update
sudo apt install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings

echo "installation de docker"
# Add Docker's official GPG key:
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the docker's repository to Apt sources:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | sudo bash
sudo usermod -aG docker $(whoami)
echo "docker installé"

echo "installation de kubernetes"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
chmod +x kubectl
sudo mv ./kubectl /usr/local/bin
echo "kubernetes installé"

echo "installation de K3D"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "K3D installé"
