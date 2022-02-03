list=$(samba-tool user list)
echo "====Usuarios Disponibles===="
echo $list
echo "============================"
echo "Que usuario deseas eliminar:"
read input
samba-tool delete $input
