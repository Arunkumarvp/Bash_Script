#!/bin/bash

# === Configuration ===
ISO_PATH="/home/dev/Downloads/linux.iso"
USB_DEVICE="/dev/sdb"  # Change this to your actual USB device (e.g., /dev/sdb)

# === Warnings ===
echo "⚠️ This will ERASE ALL DATA on $USB_DEVICE"
read -p "Type YES to continue: " confirm
if [[ "$confirm" != "YES" ]]; then
    echo "❌ Aborted."
    exit 1
fi

# === Validate ISO and Device ===
if [[ ! -f "$ISO_PATH" ]]; then
    echo "❌ Error: ISO file not found at $ISO_PATH"
    exit 1
fi

if [[ ! -b "$USB_DEVICE" ]]; then
    echo "❌ Error: $USB_DEVICE is not a valid block device!"
    lsblk
    exit 1
fi

# === Install Ventoy if not installed ===
if ! command -v ventoy &> /dev/null; then
    echo "🔄 Installing Ventoy..."
    if command -v pamac &> /dev/null; then
        pamac install --no-confirm ventoy
    else
        echo "❌ pamac not found. Install ventoy manually or use yay:"
        echo "   yay -S ventoy"
        exit 1
    fi
fi

# === Flash Ventoy to USB ===
echo "🧨 Writing Ventoy to $USB_DEVICE..."
sudo ventoy -i -Y "$USB_DEVICE"
if [[ $? -ne 0 ]]; then
    echo "❌ Ventoy installation failed!"
    exit 1
fi

# === Mount USB and copy ISO ===
MOUNT_POINT=$(lsblk -o NAME,MOUNTPOINT | grep "$(basename $USB_DEVICE)1" | awk '{print $2}')

if [[ -z "$MOUNT_POINT" ]]; then
    echo "🔍 USB not auto-mounted. Trying to mount manually..."
    MOUNT_POINT="/mnt/ventoy_usb"
    sudo mkdir -p "$MOUNT_POINT"
    sudo mount "${USB_DEVICE}1" "$MOUNT_POINT"
fi

echo "📁 Copying ISO to USB..."
cp "$ISO_PATH" "$MOUNT_POINT"
sync

echo "✅ Done! Bootable Ventoy USB created with Manjaro ISO."
echo "💡 You can add more ISOs later by copying them to the USB."
