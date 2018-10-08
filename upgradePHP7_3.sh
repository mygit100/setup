# Install 
sudo apt-get update
sudo apt-get install libmcrypt-dev

# Install php7
sudo apt-get install php7.3

# Install php7 module for apache
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y

sudo apt-get install php7.3-curl php7.3-dev php7.3-gd php7.3-intl php7.1-mcrypt php7.3-json php7.3-mysql php7.3-opcache php7.3-bcmath php7.3-mbstring php7.3-soap php7.3-xml -y

sudo apt-get install libapache2-mod-php7.3 -y

sudo apt-get install php7.3-zip -y

# Switch apache module
sudo a2dismod php5
sudo a2enmod php7.3

# Activate the new configuration, you need to run
service apache2 restart
