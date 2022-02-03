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
