#!/bin/bash

sudo apt update
wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_134.0.6998.165-1_amd64.deb
sudo dpkg -i google-chrome-stable_134.0.6998.165-1_amd64.deb
sudo apt --fix-broken install -y
sudo apt update -y && sudo apt upgrade -y

sudo apt install xfce4 xfce4-goodies xrdp -y

echo "startxfce4" > ~/.xsession
sudo chown $(whoami):$(whoami) ~/.xsession

sudo systemctl enable xrdp
