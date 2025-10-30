#!/bin/bash

echo "=== Updating system ==="
sudo apt update -y

echo "=== Installing xfce4 ==="
sudo apt install xfce4 xrdp -y

echo "startxfce4" > ~/.xsession
sudo chown $(whoami):$(whoami) ~/.xsession

sudo systemctl enable xrdp

echo "=== Installing Chrome ==="
wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_134.0.6998.165-1_amd64.deb
sudo dpkg -i google-chrome-stable_134.0.6998.165-1_amd64.deb
sudo apt --fix-broken install -y


set -e

echo "=== Installing required dependencies ==="
sudo apt install -y sudo curl gpg

echo "=== Adding Playit APT repository ==="
curl -fsSL https://playit-cloud.github.io/ppa/key.gpg | \
  gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null

echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | \
  sudo tee /etc/apt/sources.list.d/playit-cloud.list

echo "=== Installing Playit ==="
sudo apt update -y
sudo apt install -y playit

echo "=== Enabling Playit service ==="
sudo systemctl enable --now playit

echo "=== Running Playit setup ==="
playit setup

echo "✅ Playit installation complete!"
echo "➡️ Run 'playit status' to check the tunnel status."
