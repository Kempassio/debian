#!/bin/bash
# Instalar los repositorios de debian
wget https://raw.githubusercontent.com/Kempassio/debian/main/sources.list
# Remplazamos el sources list original por este.
mv ./sources.list /etc/apt/
# Instalar plugins del webmin
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip
# paso para la instalacion
cd /root
wget https://download.webmin.com/jcameron-key.asc
cat jcameron-key.asc | gpg --dearmor >/etc/apt/trusted.gpg.d/jcameron-key.gpg 
# Instalar el webmin
apt-get install apt-transport-https
apt-get update
apt-get install webmin
/etc/init.d/webmin start

