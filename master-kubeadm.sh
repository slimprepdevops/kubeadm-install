#!/bin/bash

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 > cluster-init.txt
cat cluster-init.txt 
echo "sudo"
tail -2 cluster-init.txt > token.txt
cat token.txt

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl version

kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

