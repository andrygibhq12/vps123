#!/bin/bash

sudo apt update

sudo apt update -y && sudo apt upgrade -y

wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_130.0.6723.58-1_amd64.deb
sudo dpkg -i google-chrome-stable_130.0.6723.58-1_amd64.deb
sudo apt --fix-broken install -y

sudo apt install xfce4 xfce4-goodies xrdp -y

echo "startxfce4" > ~/.xsession
sudo chown $(whoami):$(whoami) ~/.xsession

sudo systemctl enable xrdp
