#!/bin/bash

# Git global config script for Manjaro/Linux

# Ask for user details
read -p "Enter your Git username: " username
read -p "Enter your Git email: " email

# Set global name and email
git config --global user.name "$username"
git config --global user.email "$email"

# Optional: Set default editor to nano (change if needed)
git config --global core.editor nano

# Optional: Cache credentials for 1 hour
git config --global credential.helper 'cache --timeout=3600'

# Confirm setup
echo ""
echo "✅ Git has been configured:"
git config --global --list
