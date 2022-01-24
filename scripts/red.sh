#!bin/bash
clear
apt -y install net-tools
clear
echo "¿Que interfaz de red deseas modificar?"
read red
clear
echo "Direccion IP nueva:"
read ip
ifconfig $red $ip netmask 255.255.255.0
clear
ifconfig | grep -A 1 $red
