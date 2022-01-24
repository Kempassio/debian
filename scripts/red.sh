#!bin/bash
clear
apt -y install net-tools
clear
#============Functions===============
ifaced () {
echo "This file describes the network interfaces available on your system" > /etc/network/interfaces
echo "and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "#The loopback network interface" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto $red" >> /etc/network/interfaces
echo "iface $red inet $tipo" >> /etc/network/interfaces
}
ifaces () {
echo "This file describes the network interfaces available on your system" > /etc/network/interfaces
echo "and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "#The loopback network interface" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto $red" >> /etc/network/interfaces
echo "iface $red inet $tipo" >> /etc/network/interfaces
echo "  address $ip" >> /etc/network/interfaces
echo "  netmask $mask" >> /etc/network/interfaces
echo "  dns-nameservers $ip" >> /etc/network/interfaces
}
#====================================
echo "¿Cuantas tarjetas de red tienes?"
read num
clear
if [ $num = 1]
then
echo "¿Que interfaz de red deseas modificar?"
read red
clear
echo "¿dhcp o static?"
read tipo
    if [ $tipo = 'dhcp' ]
    then
    ifaced
    else
    echo "Direccion IP nueva: "
    read ip
    clear
    echo "Mascara de Red: "
    read mask
    clear
    ifaces
    fi 
else
   echo "¿Que interfaz de red deseas modificar?"
    read red
    clear
    echo "¿dhcp o static?"
    read tipo
    if [ $tipo = 'dhcp' ]
    then
    ifaced
    else
    echo "Direccion IP nueva: "
    read ip
    clear
    echo "Mascara de Red: "
    read mask
    clear
    ifaces
    fi
    echo "¿Que interfaz de red deseas modificar?"
    read red
    clear
    echo "¿dhcp o static?"
    read tipo
    if [ $tipo = 'dhcp' ]
    then
    ifaced
    else
    echo "Direccion IP nueva: "
    read ip
    clear
    echo "Mascara de Red: "
    read mask
    clear
    ifaces
    fi

fi
clear
ifconfig | grep -A 1 $red
