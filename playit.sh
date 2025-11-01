#!/bin/bash

echo "=== Updating system ==="
sudo apt update -y

echo "=== Installing xfce4 ==="
sudo apt install lxde -y
sudo apt install xrdp -y > /dev/null 2>&1
echo "lxsession -s LXDE -e LXDE" >> /etc/xrdp/startwm.sh > /dev/null 2>&1
sudo systemctl enable xrdp > /dev/null 2>&1

echo "=== Installing Chrome ==="
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
sudo dpkg -i google-chrome-stable_current_amd64.deb > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1


set -e

echo "=== Installing Playit ==="
sudo apt install -y sudo curl gpg > /dev/null 2>&1

curl -fsSL https://playit-cloud.github.io/ppa/key.gpg | \
  gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg > /dev/null 2>&1

echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | \
  sudo tee /etc/apt/sources.list.d/playit-cloud.list > /dev/null 2>&1

sudo apt update -y > /dev/null 2>&1
sudo apt install -y playit > /dev/null 2>&1

sudo systemctl enable --now playit > /dev/null 2>&1

echo "=== Running Playit setup ==="
playit setup

echo "✅ Playit installation complete!"
echo "➡️ Run 'playit status' to check the tunnel status."
