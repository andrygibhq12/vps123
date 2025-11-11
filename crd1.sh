#! /bin/bash
printf "Installing CRD-server... \nThis might take a while... " >&2
{
sudo useradd -m $USERNAME
sudo adduser $USERNAME sudo
echo '$USERNAME:$PASSWORD' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken

sudo DEBIAN_FRONTEND=noninteractive \
sudo apt install --assume-yes xfce4 xfce4-goodies
echo "exec xfce4-session" > ~/.chrome-remote-desktop-session
chmod +x ~/.chrome-remote-desktop-session  
sudo apt remove --assume-yes gnome-terminal

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 
sudo adduser $USERNAME chrome-remote-desktop
} &> /dev/null &&
printf "\nSetup Complete \nCreated new usergibhq with password:gibhq \nYou can change both b4iterdev's password with passwd(with no sudo) \nOr you can change root's password with sudo passwd" >&2 ||
printf "\nError Occured " >&2
printf '\nCheck https://remotedesktop.google.com/headless and copy command of Debian Linux \n'
read -p "Paste Here: " CRP
su - $USERNAME -c """$CRP"""
printf 'Check https://remotedesktop.google.com/access/ \n\n'
