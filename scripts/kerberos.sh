sudo apt -y install samba smbclient winbind krb5-config
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
