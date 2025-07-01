#!/bin/bash

# Base Cleanup Script for Manjaro Linux
# Clears temp and cache files safely

echo "Starting system cleanup..."

# 1. Clear user and root Trash
echo "Clearing Trash folders..."
rm -rf ~/.local/share/Trash/* 
sudo rm -rf /root/.local/share/Trash/*

# 2. Clear systemd journal logs (keep last 3 days)
echo "Cleaning journal logs..."
sudo journalctl --vacuum-time=3d

# 3. Clear package cache (remove unused packages)
echo "Clearing unused package cache..."
sudo pacman -Sc --noconfirm

# 4. Optionally, clear entire package cache (CAUTION)
# echo "Clearing entire package cache..."
# sudo pacman -Scc --noconfirm

# 5. Clean temporary files
echo "Removing temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# 6. Clear user cache
echo "Cleaning user cache..."
rm -rf ~/.cache/*

echo "Cleanup completed successfully! ✅"
