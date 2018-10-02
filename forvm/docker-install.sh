#!/bin/bash
echo "This script will install Docker CE."
echo "Press any key to continue."
read -n 1
sudo apt-get remove docker docker-engine docker.io

sudo apt-get update


sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common -y

sudo apt-get install docker-compose -y


curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce -y


apt-cache madison docker-ce
sudo docker run hello-world
