#!/bin/bash 

# This script works on Debian 9 "Stretch" 

# Need to install sudo and add your account to sudoer group.
#
# su root 
# apt install git sudo -y 

# Add to sudo group 
# usermod -a -G sudo $Myuser 

# or 
# echo "$Myuser ALL=(ALL:ALL) ALL" >> /etc/sudoers 

# Set variables 
clear
echo -n "Enter a valid account you want to setup sudo for and press [ENTER]:    "
read Myuser

echo "" 
echo -n "Enter the name of the log file to log this installation and press [ENTER]:    "
read mylogfile

echo "" 
#read -p "Which editor would you like to install? [Atom, VS_Code, None]:    " the_editor

read -p "Which editor would you like to install? [Atom, VS_Code]" the_editor
    case $the_editor in
        [Atom]* ) ;;
        [VS_Code]* ) ;;
        * ) echo "No Editor Selected";;
    esac

read -p "Do you want to install Dropbox? [yn]" installdropbox
echo "" 
echo "" 

read -p "Do you want to install RescueMe? [yn]" installRescueMe
echo "" 
echo "" 

read -p "Do you want to install Dell wifi drivers? [yn]" installDellWifiDrivers
echo "" 
echo "" 

read -p "Do you want to install KVM Virtual Machine? [yn]" installKVM
echo "" 
echo "" 

#Myuser=<username> 
#mylogfile=tracker 

# Git debian setup script 
# wget https://raw.githubusercontent.com/mygit100/setup/master/debian-install.sh 

sudo apt-get install xterm 

# Launch a separate terminal to track script 
touch ~/$mylogfile 
xterm -e bash -c 'watch -n 0.1 cat ~/'$mylogfile & 

echo "Use this window to track script status" > ~/$mylogfile 
echo "" >> ~/$mylogfile 

echo "Adding non-free to sources.list" >> ~/$mylogfile 
sudo sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list 

echo "Updating" >> ~/$mylogfile 
sudo apt-get update 

echo "Locating the fastest Debian download site" >> ~/$mylogfile 
sudo apt-get install netselect-apt -y 
sudo netselect-apt 

echo "Installing my base applications" >> ~/$mylogfile 
echo "   1. Tmux" >> ~/$mylogfile 
echo "   2. Chromium" >> ~/$mylogfile 
echo "   3. VIM" >> ~/$mylogfile 
echo "   4. SSH" >> ~/$mylogfile 
echo "   5. XRDP" >> ~/$mylogfile 
sudo apt-get install tmux chromium xrdp openssh-server vim libcanberra-gtk-module fonts-crosextra-carlito fonts-crosextra-caladea -y 

# Changing RDP access from root only to all users 
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config 

case $the_editor in
    Atom)
        echo "   6. Atom Text Editor" >> ~/$mylogfile 
        wget https://atom.io/download/deb -O atom.deb 
        DEBIAN_FRONTEND=noninteractive sudo dpkg -i atom.deb 
        sudo apt-get install -f -y 
        DEBIAN_FRONTEND=noninteractive sudo dpkg -i atom.deb 
        rm atom.deb 
        ;;
    VS_Code)
        echo "   6. Visual Studio Code Editor" >> ~/$mylogfile 
        wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb 
        DEBIAN_FRONTEND=noninteractive sudo dpkg -i vscode.deb 
        sudo apt-get install -f -y 
        DEBIAN_FRONTEND=noninteractive sudo dpkg -i vscode.deb 
        rm vscode.deb
        ;;
    *)
        echo "   6. No Editor Selected" >> ~/$mylogfile 
        ;;
esac



if [ $installdropbox == 'y']
    then
        echo "   7. Dropbox" >> ~/$mylogfile 
        cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - 
        echo "       To launch Dropbox, in a terminal window" >> ~/$mylogfile 
        echo "       type --> ~/.dropbox-dist/dropboxd" >> ~/$mylogfile 
fi

if [ $installRescueMe == 'y']
    then
        echo "   8. Rescuetime" >> ~/$mylogfile 
        wget "https://www.rescuetime.com/installers/rescuetime_current_amd64.deb" 
        DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb 
        sudo apt-get install -f -y 
        DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb 
        rm rescuetime_current_amd64.deb 

        echo "       To launch RescueTime, in a terminal window" >> ~/$mylogfile 
        echo "       type --> rescuetime" >> ~/$mylogfile 
fi

# Dell  wireless drivers
if [ $installDellWifiDrivers == 'y']
    then
        echo "Istalling Dell wifi drivers" >> ~/$mylogfile 
        sudo apt-get install firmware-iwlwifi 
fi

# Installing KVM 
if [ $installKVM == 'y']
    then
        echo "Installing KVM" >> ~/$mylogfile 
        sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin -y 

        echo "Installing Virtual Manager" >> ~/$mylogfile 
        sudo apt-get install virt-manager -y 

        sudo adduser $Myuser libvirt 
        sudo adduser $Myuser libvirt-qemu 

        newgrp libvirt 
        newgrp libvirt-qemu 
fi


# Install preferred desktop environment 
echo "Installing Cinnamon desktop" >> ~/$mylogfile 
sudo apt-get install cinnamon -y 
echo "   Finished installing Cinnamon desktop" >> ~/$mylogfile 

# note wireless interface is wlp2s0  
echo "Cleaning up" >> ~/$mylogfile 
sudo apt-get -f install && 
sudo apt-get autoremove && 
sudo apt-get -y autoclean && 
sudo apt-get -y clean 

