#!/bin/bash

# su root
# apt install git sudo -y

# Add to sudo group
# usermod -a -G sudo <username>

# or
# echo "<username> ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Git debian setup script
# wget https://raw.githubusercontent.com/mygit100/setup/master/debian-install.sh

sudo apt-get install xterm

# Launch a separate terminal to track script
touch ~/tracker
xterm -e bash -c 'watch -n 0.1 cat ~/tracker' &

echo "Use this window to track script status" > ~/tracker
echo "" >> ~/tracker

echo "Adding non-free to sources.list" >> ~/tracker
sudo sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list

echo "Updating" >> ~/tracker
sudo apt-get update

echo "Locating the fastest Debian download site" >> ~/tracker
sudo apt-get install netselect-apt -y
sudo netselect-apt

echo "Installing my base applications" >> ~/tracker
echo "   1. Tmux" >> ~/tracker
echo "   2. Chromium" >> ~/tracker
echo "   3. VIM" >> ~/tracker
echo "   4. SSH" >> ~/tracker
sudo apt-get install tmux chromium openssh-server vim libcanberra-gtk-module fonts-crosextra-carlito fonts-crosextra-caladea conky -y

echo "   5. Atom Text Editor" >> ~/tracker
wget https://atom.io/download/deb -O atom.deb
DEBIAN_FRONTEND=noninteractive sudo dpkg -i atom.deb
sudo apt-get install -f -y
DEBIAN_FRONTEND=noninteractive sudo dpkg -i atom.deb
rm atom.deb

echo "   6. Dropbox" >> ~/tracker
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
echo "       To launch Dropbox, in a terminal window" >> ~/tracker
echo "       type --> ~/.dropbox-dist/dropboxd" >> ~/tracker

echo "   7. Rescuetime" >> ~/tracker
wget "https://www.rescuetime.com/installers/rescuetime_current_amd64.deb"
DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb
sudo apt-get install -f -y
DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb
rm rescuetime_current_amd64.deb

echo "       To launch RescueTime, in a terminal window" >> ~/tracker
echo "       type --> rescuetime" >> ~/tracker

# Install preferred desktop environment
echo "Installing Cinnamon desktop" >> ~/tracker
sudo apt-get install cinnamon -y
echo "   Finished installing Cinnamon desktop" >> ~/tracker

# Dell  wireless drivers
echo "Istalling Dell wifi drivers" >> ~/tracker
sudo apt-get install firmware-iwlwifi
# note wireless interface is wlp2s0

echo "Cleaning up" >> ~/tracker
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean

# Installing KVM
echo "Installing KVM" >> ~/tracker
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin -y

echo "Installing Virtual Manager" >> ~/tracker
sudo apt-get install virt-manager -y

sudo adduser reverset libvirt
sudo adduser reverset libvirt-qemu

newgrp libvirt
newgrp libvirt-qemu
