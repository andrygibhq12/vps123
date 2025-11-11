#!/bin/bash

{
username="gibhq"
password="gibhq"
sudo useradd -m "$username"
sudo adduser "$username" sudo
echo "$username:$password" | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
} > /dev/null 2>&1

CRP=""
Pin=123456

installCRD() 
printf 'Installing Crd...'
{
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
} > /dev/null 2>&1

installDesktopEnvironment() 
printf 'Installing Xfce4...'
{  
sudo apt install --assume-yes xfce4 xfce4-goodies
echo "exec xfce4-session" > ~/.chrome-remote-desktop-session
chmod +x ~/.chrome-remote-desktop-session
sudo apt remove --assume-yes gnome-terminal
} > /dev/null 2>&1

installBrowser() 
printf 'Installing Browser...'
{
wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_130.0.6723.116-1_amd64.deb
sudo dpkg --install google-chrome-stable_130.0.6723.116-1_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install --assume-yes remmina remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret
sudo apt install --assume-yes python3-pip
sudo pip install gdown
} > /dev/null 2>&1

getCRP() 
printf 'Check https://remotedesktop.google.com/headless'
{
read -p "SSH Code: " CRP
if [ -z "$CRP" ]; then
    echo "Please enter a valid value."
    getCRP
fi
}

finish() 
{
sudo groupadd chrome-remote-desktop
sudo adduser $username chrome-remote-desktop
command="$CRP --pin=$Pin"
sudo su - $username -c "$command"
sudo /etc/init.d/chrome-remote-desktop start
}

# Main
sudo apt update
installCRD
installDesktopEnvironment
installBrowser
getCRP
finish

while true; do sleep 10; done
