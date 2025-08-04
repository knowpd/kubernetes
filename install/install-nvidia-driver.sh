# 2025-08-04 knowpd

#!/bin/bash
set -e

# Install kernel headers
sudo apt update
sudo apt install -y build-essential dkms linux-headers-$(uname -r)

# Install recommended driver 
sudo apt install -y nvidia-driver-535-server   # This is for Telsa T4

# Install CUDA utiltiies
sudo apt install -y nvidia-cuda-toolkit

# Reboot required
echo "Driver installed. Please reboot the system. To verify, run nvidia-smi"
