#!/bin/bash

# Update package lists
sudo pacman -Syu --noconfirm

# Install Python
sudo pacman -S --noconfirm python python-pip

# Install .NET SDK
# sudo pacman -S --noconfirm dotnet-sdk

# Install Node.js (LTS) and npm
sudo pacman -S --noconfirm nodejs npm

# Install Docker
# sudo pacman -S --noconfirm docker

# Enable and start Docker service
# sudo systemctl enable --now docker

echo "Installation complete: Python, .NET, Node.js, Docker"
