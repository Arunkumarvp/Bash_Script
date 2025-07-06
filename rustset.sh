#!/bin/bash
# Install Rust and set up the environment

set -e

update_system() {
    echo "Updating system..."
    sudo pacman -Syu --noconfirm
}

install_rust() {
    if command -v rustc >/dev/null 2>&1; then
        echo "Rust is already installed."
    else
        echo "Installing Rust..."
        sudo pacman -S --noconfirm rust
    fi
}

install_rustup() {
    if command -v rustup >/dev/null 2>&1; then
        echo "rustup is already installed."
    else
        echo "Installing rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        if [ -f "$HOME/.cargo/env" ]; then
            source "$HOME/.cargo/env"
            echo "rustup installed and environment set."
        else
            echo "Warning: $HOME/.cargo/env not found. Please check rustup installation."
        fi
    fi
}

install_rust_analyzer() {
    if command -v rust-analyzer >/dev/null 2>&1; then
        echo "rust-analyzer is already installed."
    else
        echo "Installing rust-analyzer..."
        sudo pacman -S --noconfirm rust-analyzer
        echo "rust-analyzer installed."
    fi
}

main() {
    update_system
    install_rust

    read -p "Do you want to install rustup (recommended for managing stable/nightly toolchains)? (y/n): " install_rustup_ans
    if [[ "$install_rustup_ans" =~ ^[Yy]$ ]]; then
        install_rustup
    else
        echo "Skipping rustup installation."
    fi

    read -p "Do you want to install rust-analyzer for JetBrains IDE support? (y/n): " install_ra_ans
    if [[ "$install_ra_ans" =~ ^[Yy]$ ]]; then
        install_rust_analyzer
    else
        echo "Skipping rust-analyzer installation."
    fi
}

# 🛠️ Important: Call the main function to execute the script
main
