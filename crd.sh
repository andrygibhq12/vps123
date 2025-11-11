#!/bin/bash

sudo apt update -y

echo "===> Installing CRD"
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
sudo dpkg -i chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1

echo "===> Installing Xfce"
sudo apt install xfce4 xfce4-goodies xrdp -y > /dev/null 2>&1
echo "exec xfce4-session" > ~/.chrome-remote-desktop-session
chmod +x ~/.chrome-remote-desktop-session
sudo apt remove gnome-terminal -y > /dev/null 2>&1

echo "===> Installing Gdown"
sudo apt install python3-pip -y > /dev/null 2>&1
sudo pip install gdown > /dev/null 2>&1

echo "===> Installing Chrome"
wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
sudo dpkg -i google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1

echo "===> Installing Remmina"
sudo apt install remmina remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret -y > /dev/null 2>&1
