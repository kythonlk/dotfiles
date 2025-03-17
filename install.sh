#!/bin/bash

echo "🔹 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install snapd

echo "🔹 Installing APT packages..."
sudo apt install -y chrome-gnome-shell \
    tmux \
    fzf \
    ripgrep \
    xclip \
    vlc \
    btop \
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
sudo snap install go --classic

echo "🔹 Installing Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

echo "🔹 Installing Brave..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

echo "🔹 Installing Anydesk..."
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /usr/share/keyrings/anydesk-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/anydesk-archive-keyring.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt update && sudo apt install anydesk -y


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
    && gnome-extensions enable Resource_Monitor@Ory0n

echo "🔹 Adding user to Docker group..."
sudo usermod -aG docker $USER
newgrp docker

echo "✅ Installation completed!"
