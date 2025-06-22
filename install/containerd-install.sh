#!/bin/bash
# 2025-06-22 knowpd
# <https://github.com/containerd/containerd/blob/main/docs/getting-started.md>

set -e

# Versions
CONTAINERD_VERSION="2.1.3"
RUNC_VERSION="1.3.0"
CNI_VERSION="v1.7.1"

ARCH="amd64"
OS="linux"

# Directories
CNI_DIR="/opt/cni/bin"
SYSTEMD_DIR="/usr/local/lib/systemd/system"

# Create temp working directory
WORKDIR=$(mktemp -d)
cd "$WORKDIR"


### Step 1: Install containerd
echo "Downloading and installing containerd..."
curl -LO "https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/containerd-${CONTAINERD_VERSION}-${OS}-${ARCH}.tar.gz"
sudo tar -C /usr/local -xzvf "containerd-${CONTAINERD_VERSION}-${OS}-${ARCH}.tar.gz"

echo "Setting up containerd systemd service..."
sudo mkdir -p "${SYSTEMD_DIR}"
sudo curl -o "${SYSTEMD_DIR}/containerd.service" https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd


### Step 2: Install runc
echo "Downloading and installing runc..."
curl -LO "https://github.com/opencontainers/runc/releases/download/v${RUNC_VERSION}/runc.${ARCH}"
sudo install -m 755 "runc.${ARCH}" /usr/local/sbin/runc


### Step 3: Install CNI plugins
echo "Downloading and installing CNI plugins..."
sudo mkdir -p "${CNI_DIR}"
curl -LO "https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-${OS}-${ARCH}-${CNI_VERSION}.tgz"
sudo tar -C "${CNI_DIR}" -xzvf "cni-plugins-${OS}-${ARCH}-${CNI_VERSION}.tgz"

echo "Cleanup..."
rm -rf "$WORKDIR"

echo "Installation complete."

