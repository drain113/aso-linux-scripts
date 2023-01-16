#!/bin/bash
##
#
##

function crear () {
    clear
# VERIFICAR QUE ERES USUARIO ROOT
if [ $(id -u) -eq 0 ]; then
# SI LO ES, ENTONCES CREA EL USUARIO CON NOMBRE Y PASSWORD
    read -p "Introduce el nombre de usuario " nombre
    read -p "Introduce la contraseña del usuario " password
    useradd -p $password -L $nombre
    echo "El usuario añadido ha sido creado y está bloqueado."
    else
        echo "Debes ser usuario root"
        read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
fi
}

function habilitar () {
    clear
    read -p "Introduce el nombre de usuario " nombre
# Check de si el usuario existe
    egrep "^$nombre" /etc/passwd >/dev/null
# $? -eq 0 = si existe , $? -eq 1 = no existe
if [ $? -ne 0 ]; then
    echo "El usuario $nombre no existe, por favor pulsa 1 en el menú para crearlo"
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC

else
    # Grep simple para buscar ! delante del nombre del usuario en /etc/shadow que indica que está deshabilitado
    if grep -q "$nombre:!" <<< "/etc/shadow"; then
    usermod -U user1
    else
    echo "El usuario $nombre ya está habilitado"
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC

fi
fi
}






#-----------------------------------------------------Menú-----------------------------------------------------

OPC="0"
until [ $OPC = "9" ]; do
    clear
    echo "[ Seleccione una opción]"
    echo "1. Crear usuario "
    echo "2. Habilitar usuario "
    echo "3. Deshabilitar usuario "
    echo "4. Cambiar permisos a un usuario "
    echo "5. Copia de seguridad del directorio de trabajo de un usuario determinado "
    echo "6. Usuarios conectados actualmente "
    echo "7. Espacio libre en disco "
    echo "8. Trazar ruta "
    echo "9. Salir "
    read -p "Eliga una opción (1,2,3,4,5,6,7,8,9) " OPC
    echo " "
    case $OPC in
        1) crear;;
        2) habilitar;;
        3) deshabilitar;;
        4) cambiarpermisos;;
        5) copiaseguridad;;
        6) conectados;;
        7) espaciolibre;;
        8) traceroute;;
        9) echo " Saliendo ";;
    esac
done

#------------------------------------------------------------------------------------------------------------