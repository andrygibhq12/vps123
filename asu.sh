#!/bin/bash

CRP=""
Pin=123456

installCRD() {
    echo "Installing CRD"
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
    sudo apt install --assume-yes --fix-broken > /dev/null 2>&1
}

installDesktopEnvironment() {
    echo "Installing XFCE4"
    sudo apt install --assume-yes xfce4 xfce4-goodies > /dev/null 2>&1
    echo "exec xfce4-session" > ~/.chrome-remote-desktop-session
    chmod +x ~/.chrome-remote-desktop-session
    sudo apt remove --assume-yes gnome-terminal > /dev/null 2>&1
}

installBrowser() {
    wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
    sudo dpkg --install google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
    sudo apt install --assume-yes --fix-broken > /dev/null 2>&1
}

getCRP() {
    read -p "SSH Code: " CRP
    if [ -z "$CRP" ]; then
        echo "Please enter a valid value."
        getCRP
    fi
}

finish() {
    command="$CRP --pin=$Pin"
    sudo systemctl status chrome-remote-desktop@$USER

    echo "Finished Succesfully"
}

# Main
sudo apt update > /dev/null 2>&1
installCRD
installDesktopEnvironment
installBrowser
getCRP
finish

while true; do sleep 10; done
