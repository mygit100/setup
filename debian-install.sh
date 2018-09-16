
# su root
# apt install git sudo
test

# Add to sudo group
usermod -aG sudo <username>

# Git debian setup script
git https://....

echo "Adding non-free to sources.list" &&
sudo sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list

# update
sudo apt-get update

sudo apt-get install netselect-apt -y
sudo netselect-apt

sudo apt-get install tmux chromium vim libcanberra-gtk-module fonts-crosextra-carlito fonts-crosextra-caladea -y

# Install preferred desktop environment
sudo apt-get install cinnamon -y

cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

wget "https://www.rescuetime.com/installers/rescuetime_current_amd64.deb"
sudo dpkg -i rescuetime_current_amd64.deb
rm rescuetime_current_amd64.deb


echo "Cleaning Up" &&
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean
