#!/bin/bash

# su root
# apt install git sudo -y

# Add to sudo group
# usermod -a -G sudo <username>

# or
# echo "<username> ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Git debian setup script
# wget https://raw.githubusercontent.com/mygit100/setup/conky/debian-install.sh

sudo apt-get install xterm

# Launch a separate terminal to track script
touch ~/tracker
xterm -e bash -c 'watch -n 0.1 cat ~/tracker' &

echo "Use this window to track script status" > ~/tracker
echo "" >> ~/tracker

echo "Updating" >> ~/tracker
sudo apt-get update

echo "Locating the fastest Debian download site" >> ~/tracker
sudo apt-get install netselect-apt -y
sudo netselect-apt

echo "Updating sources.list" >> ~/tracker
sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup
sudo mv sources.list /etc/apt/sources.list

echo "Updating" >> ~/tracker
sudo apt-get update

echo "Adding non-free to sources.list" >> ~/tracker
sudo sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list

echo "Installing my base applications" >> ~/tracker
echo "   1. Tmux" >> ~/tracker
echo "   2. Chromium" >> ~/tracker
echo "   3. VIM" >> ~/tracker
echo "   4. SSH" >> ~/tracker
echo "   5. Conky" >> ~/tracker
sudo apt-get install tmux chromium openssh-server vim libcanberra-gtk-module fonts-crosextra-carlito fonts-crosextra-caladea conky -y

wget https://raw.githubusercontent.com/mygit100/setup/conky/conky_primary

mkdir ~/.config/conky
cp conky_primary ~/.config/conky/conky.conf
rm conky_primary

echo "[Desktop Entry]" > ~/.config/autostart/conky.desktop
echo "Type=Application" >> ~/.config/autostart/conky.desktop
echo "Exec=sh -c \"sleep 10; conky\"" >> ~/.config/autostart/conky.desktop
echo "Name=Conky" >> ~/.config/autostart/conky.desktop
echo "Comment=Autostart conky at login" >> ~/.config/autostart/conky.desktop

# Start conky
echo "       The interface needs to be set in conky" >> ~/tracker
echo "       Run -- nmcli dev status" >> ~/tracker
echo "       For ethernet, run -- sed -i 's/eno1/xyz_interface/g' ~/.config/conky/conky.conf" >> ~/tracker
echo "       For ethernet, wireless -- sed -i 's/wlp2s0/xyz_interface/g' ~/.config/conky/conky.conf" >> ~/tracker

echo "   6. Atom Text Editor" >> ~/tracker
wget https://atom.io/download/deb -O atom.deb
DEBIAN_FRONTEND=noninteractive sudo dpkg -i atom.deb
sudo apt-get install -f -y
DEBIAN_FRONTEND=noninteractive sudo dpkg -i atom.deb
rm atom.deb

echo "   7. Dropbox" >> ~/tracker
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
echo "       To launch Dropbox, in a terminal window" >> ~/tracker
echo "       type --> ~/.dropbox-dist/dropboxd" >> ~/tracker

echo "   8. Rescuetime" >> ~/tracker
wget "https://www.rescuetime.com/installers/rescuetime_current_amd64.deb"
DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb
sudo apt-get install -f -y
DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb
rm rescuetime_current_amd64.deb

echo "       To launch RescueTime, in a terminal window" >> ~/tracker
echo "       type --> rescuetime" >> ~/tracker

echo "   9. Firejail and Firetools" >> ~/tracker
# Install preferred desktop environment
echo "Installing Cinnamon desktop" >> ~/tracker
sudo apt-get install firejail firetools cinnamon -y
echo "   Finished installing Cinnamon desktop" >> ~/tracker

# Dell  wireless drivers
echo "Installing Dell wifi drivers" >> ~/tracker
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

conky
