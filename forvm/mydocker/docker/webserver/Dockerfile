FROM php:7-apache

RUN apt-get update -y && apt-get install libpng-dev libcurl4-openssl-dev openssh-server curl git -y

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

RUN php -r "unlink('composer-setup.php');"

RUN docker-php-ext-install pdo pdo_mysql gd

RUN a2enmod rewrite
RUN service apache2 restart

RUN ls -altr /
