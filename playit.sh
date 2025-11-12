#!/bin/bash

installDesktopEnvironment() {
    echo "===> Installing Xfce4"
    sudo apt install xfce4 xfce4-goodies xrdp -y > /dev/null 2>&1
    echo "startxfce4" > ~/.xsession
    sudo chown $(whoami):$(whoami) ~/.xsession
    sudo systemctl enable xrdp > /dev/null 2>&1
}

installBrowser() {
    echo "Installing Browser"
    wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
    sudo dpkg --install google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
    sudo apt install --assume-yes --fix-broken > /dev/null 2>&1
    sudo apt install --assume-yes remmina remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret > /dev/null 2>&1
    sudo apt install --assume-yes python3-pip > /dev/null 2>&1
    sudo pip install gdown > /dev/null 2>&1
}

installPlayit() {
    echo "Installing Playit"
    sudo apt install -y sudo curl gpg > /dev/null 2>&1
    curl -fsSL https://playit-cloud.github.io/ppa/key.gpg | \
      gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg > /dev/null 2>&1
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | \
      sudo tee /etc/apt/sources.list.d/playit-cloud.list > /dev/null 2>&1
    sudo apt update -y > /dev/null 2>&1
    sudo apt install -y playit > /dev/null 2>&1
    sudo systemctl enable --now playit > /dev/null 2>&1
}

finish() {
    echo "Running Playit"
    playit setup

    echo "✅ Playit installation complete!"
    echo "➡️ Run 'playit status' to check the tunnel status."
}

# Main
sudo apt update
installDesktopEnvironment
installBrowser
installPlayit
finish

while true; do sleep 10; done
