#! /bin/bash

echo "Installing microk8s via snap"
sudo snap install microk8s --classic

echo "Checking the status"
sudo microk8s.status --wait-ready

echo "Turning on standard services"
sudo microk8s.enable dns dashboard registry ingress prometheus

echo "Making kubectl alias"
sudo snap alias microk8s.kubectl kubectl
sudo usermod -a -G microk8s vagrant

echo "Installing Docker daemon"
sudo apt-get update
sudo apt-get  install docker.io -y -q
sudo usermod -aG docker vagrant

sudo iptables -P FORWARD ACCEPT
sudo iptables -A DOCKER -j ACCEPT
