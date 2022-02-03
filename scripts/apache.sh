#/bin/bash
sudo apt update && sudo apt upgrade
curl --version
sudo apt install curl -y
curl -sSL https://packages.sury.org/apache2/README.txt | sudo bash -x

sudo apt update
sudo apt install apache2
