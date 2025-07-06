#!/bin/bash

echo "🔧 Updating system..."
sudo pacman -Syu --noconfirm

echo "📦 Installing snapd..."
sudo pacman -S snapd --noconfirm

echo "🚀 Enabling snapd.socket..."
sudo systemctl enable --now snapd.socket

echo "🔗 Creating /snap symlink for classic snaps..."
if [ ! -d /snap ]; then
    sudo ln -s /var/lib/snapd/snap /snap
    echo "✅ Symlink created at /snap"
else
    echo "⚠️ /snap already exists"
fi

echo "♻️ Restarting systemd user session (you may need to reboot manually if issues persist)..."
systemctl --user daemon-reexec || true

echo "🛠 Installing JetBrains Rider via Snap..."
sudo snap install rider --classic

echo "✅ Rider installation complete! You can launch it by typing: rider"
