#!/bin/bash
# 2025-06-22 knowpd

set -e

echo "Stopping containerd service..."
sudo systemctl disable --now containerd || echo "containerd service not found or already stopped."

echo "Removing containerd files from /usr/local..."
sudo rm -rf /usr/local/bin/containerd*
sudo rm -rf /usr/local/bin/ctr
sudo rm -rf /usr/local/bin/containerd-shim*
sudo rm -rf /usr/local/bin/containerd-stress

echo "Removing runc binary..."
sudo rm -f /usr/local/sbin/runc

echo "Removing containerd systemd service..."
sudo rm -f /usr/local/lib/systemd/system/containerd.service
sudo systemctl daemon-reload

echo "Removing CNI plugins..."
sudo rm -rf /opt/cni/bin

echo "Cleanup complete."
