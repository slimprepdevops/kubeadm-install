#!/bin/bash
######### INSTALL DOCKER ###########
# update apt
sudo apt-get update -y

#
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#
sudo mkdir -p /etc/apt/keyrings

#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#
sudo apt-get update -y

#
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#
sudo docker --version

#
sudo groupadd docker

#
sudo usermod -aG docker ${USER}

#
sudo systemctl restart docker

#
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#
sudo chmod +x /usr/local/bin/docker-compose

#
docker-compose --version

#optional
sudo apt install net-tools -y

#activate changes on group
#newgrp docker

########### DOCKER INSTALL ENDS #########

####### INSTALL KUBEADM #########
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# MODIFY CONTAINERD CONFIG FILE #
chmod 644 config.toml
sudo cp /etc/containerd/config.toml /etc/containerd/config.toml_copy
sudo cp config.toml /etc/containerd/config.toml

sudo systemctl restart containerd

echo "net.bridge.bridge-nf-call-iptables=1" |
  sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
