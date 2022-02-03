#!/bin/bash
menu(){
    clear
    echo "============MENÚ================="
    echo "1. INSTALAR APACHE"
    echo "2. CONFIGURAR RED"
    echo "3. WEBMIN"
    echo "4. KERBEROS"
    echo "5. GESTIÓN DE USUARIOS DC"
    echo "6. SALIR"
    echo "=================================="
    read input
    
    case $input in
        1) apt update && apt upgrade
            curl --version
            apt install curl -y
            curl -sSL https://packages.sury.org/apache2/README.txt | sudo bash -x
            
            apt update
            apt install apache2
        ;;
        
        2) clear
            #============Functions===============
            ifaced () {
                echo "#This file describes the network interfaces available on your system" > /etc/network/interfaces
                echo "#and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
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
                echo "#This file describes the network interfaces available on your system" > /etc/network/interfaces
                echo "#and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
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
            if [ $num = 1 ]
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
            ip a
        ;;
        
        3) clear
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
            clear
        ;;
        4) clear
            apt -y install samba smbclient winbind krb5-config
            #hacer una copia de los archivos
            mv /etc/samba/smb.conf /etc/samba/smb.conf.copy
            #Nuevo fichero de configuracion de samba
            cd /etc/samba
            samba-tool domain provision
            #mover el archivo que nos creo anteriormente
            mv /var/lib/samba/private/krb5.conf /etc
            #ejecutar estos comandos
            systemctl stop smbd winbind systemd-resolved
            systemctl disable smbd nmbd winbind system-resolved
            systemctl unmask samba-ad-dc
            systemctl enable samba-ad-dc
            systemctl restart samba-ad-dc
            systemctl status samba-ad-dc
            clear
        ;;
        5) clear
            echo "====Gestion de Usuarios===="
            echo "1. Crear Usuarios"
            echo "2. Eliminar Usuarios"
            echo "3. Listar Usuarios"
            echo "4. Volver atras"
            echo "==========================="
            read input
            case $input in
                1)
                    cuser(){
                        clear
                        echo "Nombre de Usuario:"
                        read name
                        if [ -z "$name" ]
                        then
                            echo "No puedes dejar el campo vacio"
                            sleep 1
                            cuser
                        else
                            echo "Contraseña(Mín 8 digitos, numeros, letras y simbolos):"
                            read -s pwd
                            echo "Repite la contraseña:"
                            read -s pwd1
                            if [ $pwd = $pwd1 ]
                            then
                                samba-tool user create $name $pwd
                            else
                                echo "No coinciden las contraseñas"
                                sleep 0.5
                                cuser
                            fi
                        fi
                    }
                    cuser
                ;;
                2)
                    list=$(samba-tool user list)
                    echo "====Usuarios Disponibles===="
                    echo $list
                    echo "============================"
                    echo "Que usuario deseas eliminar:"
                    read input
                    samba-tool delete $input
                ;;
                3) clear
                    samba-tool user list
                ;;
                4) menu
            esac
            6) exit 0
    esac
}
while true
do
    menu
done
