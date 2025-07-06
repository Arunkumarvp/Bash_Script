#!/bin/bash

# Improve performance on Arch/Manjaro XFCE by removing unwanted packages and disabling services

# Remove unwanted packages (example: games, office, printing, bluetooth)
sudo pacman -Rns --noconfirm \
    libreoffice-* \
    hexchat \
    thunderbird \
    gnome-games \
    cups \
    bluez \
    bluez-utils \
    xfce4-screensaver

# Disable unnecessary services
# sudo systemctl disable --now bluetooth.service
sudo systemctl disable --now cups.service
sudo systemctl disable --now avahi-daemon.service

# Clean package cache
sudo pacman -Scc --noconfirm

# Enable zram for better memory usage (optional)
if ! grep -q zram /etc/fstab; then
    echo "zram enabled for better memory usage"
    sudo pacman -S --noconfirm zram-generator
    sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
EOF
    sudo systemctl restart systemd-zram-setup@zram0.service
fi

echo "Performance tweaks applied. Please reboot for all changes to take effect."