#!/bin/bash

echo "=== Updating system ==="
sudo apt update -y > /dev/null 2>&1

echo "=== Installing xfce4 ==="
sudo apt install xfce4 xrdp -y > /dev/null 2>&1

echo "startxfce4" > ~/.xsession
sudo chown $(whoami):$(whoami) ~/.xsession > /dev/null 2>&1
sudo systemctl enable xrdp > /dev/null 2>&1

echo "=== Installing Chrome ==="
wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_134.0.6998.165-1_amd64.deb > /dev/null 2>&1
sudo dpkg -i google-chrome-stable_134.0.6998.165-1_amd64.deb > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1


set -e

echo "=== Installing required dependencies ==="
sudo apt install -y sudo curl gpg > /dev/null 2>&1

echo "=== Adding Playit APT repository ==="
curl -fsSL https://playit-cloud.github.io/ppa/key.gpg | \
  gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null

echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | \
  sudo tee /etc/apt/sources.list.d/playit-cloud.list > /dev/null 2>&1

echo "=== Installing Playit ==="
sudo apt update -y > /dev/null 2>&1
sudo apt install -y playit > /dev/null 2>&1

echo "=== Enabling Playit service ==="
sudo systemctl enable --now playit > /dev/null 2>&1

echo "=== Running Playit setup ==="
playit setup

echo "✅ Playit installation complete!"
echo "➡️ Run 'playit status' to check the tunnel status."
