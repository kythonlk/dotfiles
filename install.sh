#!/bin/bash

echo "🔹 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install snapd

echo "🔹 Installing APT packages..."
sudo apt install -y 
    chrome-gnome-shell \
    tmux \
    vlc \
    remmina \
    btop \
    golang \
    gcc \
    openjdk-19-jdk \
    fonts-hack \
    network-manager \
    docker.io \
    docker-compose \
    gnome-shell-extensions \
    gnome-tweaks

echo "🔹 Installing Snap packages..."
sudo snap install android-studio --classic
sudo snap install nvim --classic
sudo snap install beekeeper-studio --classic

echo "🔹 Installing Node.js via NVM..."
if ! command -v nvm &> /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
    source ~/.bashrc
fi
nvm install --lts
nvm use --lts

echo "🔹 Installing GNOME Extensions..."
flatpak install -y flathub org.gnome.Extensions
gnome-extensions enable blur-my-shell@aunetx \
    && gnome-extensions enable clipboard-indicator@tudmotu.com \
    && gnome-extensions enable resource-monitor@oryon

echo "🔹 Adding user to Docker group..."
sudo usermod -aG docker $USER
newgrp docker

echo "✅ Installation completed!"
