#!/bin/bash

{
username="gibhq"
password="gibhq"
useradd -m "$username"
adduser "$username" sudo
echo "$username:$password" | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
} > /dev/null 2>&1

CRP=""
Pin=123456

installCRD() {
    echo "Installing Crd"
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
    sudo apt install --assume-yes --fix-broken > /dev/null 2>&1
}

installDesktopEnvironment() {
    echo "Installing Xfce"
    sudo apt install --assume-yes xfce4 xfce4-goodies > /dev/null 2>&1
    echo "exec xfce4-session" > ~/.chrome-remote-desktop-session
    chmod +x ~/.chrome-remote-desktop-session
    sudo apt remove --assume-yes gnome-terminal > /dev/null 2>&1
}

installBrowser() {
    echo "Installing Browser"
    sudo apt install remmina remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret -y > /dev/null 2>&1
    
    sudo apt install python3-pip -y > /dev/null 2>&1
    sudo pip install gdown > /dev/null 2>&1
    
    wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
    sudo dpkg --install google-chrome-stable_130.0.6723.116-1_amd64.deb > /dev/null 2>&1
    sudo apt install --assume-yes --fix-broken > /dev/null 2>&1
}

getCRP() {
    printf '\nCheck https://remotedesktop.google.com/headless \n'
    read -p "SSH Code: " CRP
    if [ -z "$CRP" ]; then
        echo "Please enter a valid value."
        getCRP
    fi
}

finish() {
    sudo adduser chrome-remote-desktop
    command="$CRP --pin=$Pin"
    sudo su -c "$command"
}


# Main
sudo apt update
installCRD
installDesktopEnvironment
installBrowser
getCRP
finish

while true; do sleep 10; done
