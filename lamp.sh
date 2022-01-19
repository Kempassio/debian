#!/bin/bash
echo "¿Desea instalar tasksel?(s/n)"
read res
if [ $res = 's' ]
then
apt install tasksel
tasksel
else
tasksel
fi
