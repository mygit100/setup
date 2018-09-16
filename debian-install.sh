
# su root
# apt install git sudo -y

# Add to sudo group
# usermod -a -G sudo <username>

# or
# echo "<username> ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Git debian setup script
# git https://github.com/mygit100/setup/blob/master/debian-install.sh

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

echo "Installing my wish list" >> ~/tracker
echo "   1. Tmux" >> ~/tracker
echo "   2. Chromium" >> ~/tracker
echo "   3. VIM" >> ~/tracker
sudo apt-get install tmux chromium vim libcanberra-gtk-module fonts-crosextra-carlito fonts-crosextra-caladea -y

# Install preferred desktop environment
echo "Installing Cinnamon desktop" >> ~/tracker
sudo apt-get install cinnamon -y
echo "... Finished installing Cinnamon desktop" >> ~/tracker

echo "Installing Dropbox" >> ~/tracker
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
echo "... To launch Dropbox, in a terminal window" >> ~/tracker
echo "    type --> ~/.dropbox-dist/dropboxd" >> ~/tracker

echo "Installing Rescuetime" >> ~/tracker
wget "https://www.rescuetime.com/installers/rescuetime_current_amd64.deb"
DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb
sudo apt-get install -f -y
DEBIAN_FRONTEND=noninteractive sudo dpkg -i rescuetime_current_amd64.deb
rm rescuetime_current_amd64.deb

echo "... To launch RescueTime, in a terminal window" >> ~/tracker
echo "    type --> rescuetime" >> ~/tracker

# Dell drivers
echo "Downloading and installing wifi drivers" >> ~/tracker
wget http://ftp.us.debian.org/debian/pool/non-free/f/firmware-nonfree/firmware-iwlwifi_20180825+dfsg-1_all.deb

DEBIAN_FRONTEND=noninteractive sudo dpkg -i firmware-iwlwifi_20180825+dfsg-1_all.deb
sudo apt-get install -f -y
DEBIAN_FRONTEND=noninteractive sudo dpkg -i firmware-iwlwifi_20180825+dfsg-1_all.deb
rm firmware-iwlwifi_20180825+dfsg-1_all.deb

cd ~ && wget -O - "https://wireless.wiki.kernel.org/_media/en/users/drivers/iwlwifi-7265-ucode-25.30.14.0.tgz" | tar xzf -

sudo cp ~/iwlwifi-7265-ucode-25.30.14.0/iwlwifi-7265-14.ucode /lib/firmware
sudo cp ~/iwlwifi-7265-ucode-25.30.14.0/iwlwifi-7265D-14.ucode /lib/firmware

rm -rf ~/iwlwifi-7265-ucode-25.30.14.0

# Installing KVM
echo "Installing KVM" >> ~/tracker
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin -y

echo "Virtual Manager" >> ~/tracker
sudo apt-get install virt-manager -y

sudo adduser reverset libvirt
sudo adduser reverset libvirt-qemu

newgrp libvirt
newgrp libvirt-qemu


echo "Cleaning up" >> ~/tracker
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean
