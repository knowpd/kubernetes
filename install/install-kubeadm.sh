#!/bin/bash
# 2025-06-22 knowpd
# <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/>

set -e


# Disable all swaps from /proc/swaps
sudo swapoff -a

### Step 1: Update the apt package index and install packages needed to use the Kubernetes apt repository:
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg


### Step 2: Download the public signing key for the Kubernetes package repositories.
# If the directory `/etc/apt/keyrings` does not exist, it should be created.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


### Step 3: Add the appropriate Kubernetes apt repository. 
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list


### Step 4: Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version:
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


### Step 5: (Optional) Enable the kubelet service before running kubeadm:
sudo systemctl enable --now kubelet


### Step 6:
# Enable IP Forwarding
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
