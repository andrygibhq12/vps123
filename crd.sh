#!/bin/bash

username="user"
password="root"
directory_path="/home/user"
sudoers_file="/etc/sudoers"
sudoers_entry="$username    ALL=(ALL:ALL) ALL"
new_password="root"

useradd -m "$username" > /dev/null 2>&1

adduser "$username" sudo > /dev/null 2>&1

echo "$username:$password" | sudo chpasswd > /dev/null 2>&1

sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd > /dev/null 2>&1

sudo adduser --disabled-password "$username" > /dev/null 2>&1

sudo chmod -R 777 "$directory_path" > /dev/null 2>&1

echo "$sudoers_entry" | sudo tee -a "$sudoers_file"  > /dev/null 2>&1

echo -e "$new_password\n$new_password" | sudo passwd "$username" > /dev/null 2>&1

CRP=""
Pin=123456
Autostart=true

installCRD() {
    echo "Installing CRD"
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb > /dev/null 2>&1
    sudo apt install --assume-yes --fix-broken > /dev/null 2>&1
}

installDesktopEnvironment() {
    echo "Installing XFCE4"
    export DEBIAN_FRONTEND=noninteractive > /dev/null 2>&1
    sudo apt install --assume-yes xfce4 desktop-base xfce4-terminal > /dev/null 2>&1
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session' > /dev/null 2>&1
    sudo apt remove --assume-yes gnome-terminal > /dev/null 2>&1
    sudo apt install --assume-yes xscreensaver > /dev/null 2>&1
    sudo systemctl disable lightdm.service > /dev/null 2>&1
}

installBrowser() {
    echo "Installing Browser"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
    sudo dpkg --install google-chrome-stable_current_amd64.deb > /dev/null 2>&1
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
    if [ $Autostart = true ]; then
        mkdir -p /home/$username/.config/autostart
        link=""
        colab_autostart="[Desktop Entry]
Type=Application
Name=Colab
Exec=sh -c \"sensible-browser $link\"
Icon=
Comment=Open a predefined notebook at session signin.
X-GNOME-Autostart-enabled=true"
        echo "$colab_autostart" > /home/$username/.config/autostart/colab.desktop
        chmod +x /home/$username/.config/autostart/colab.desktop
        chown $username:$username /home/$username/.config
    fi

    adduser $username chrome-remote-desktop
    command="$CRP --pin=$Pin"
    su - $username -c "$command"
    service chrome-remote-desktop start

    echo "Finished Succesfully"
}

# Main
apt update > /dev/null 2>&1
installCRD
installDesktopEnvironment
installBrowser
getCRP
finish

while true; do sleep 10; done
