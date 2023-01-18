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
    adduser $nombre -q
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
    if grep -q -i "$nombre:!" /etc/shadow; then
    usermod -U $nombre
    else
    echo "ERROR: El usuario $nombre ya estaba habilitado"
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC

fi
echo "EL usuario $nombre ha sido habilitado"
read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
fi

}

function deshabilitar () {
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
    if grep -q -i "$nombre:!" /etc/shadow; then
    echo "ERROR: El usuario $nombre ya estaba deshabilitado"
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
    else
    usermod -L $nombre


fi
echo "EL usuario $nombre ha sido deshabilitado"
read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
fi

}

function cambiarpermisos () {
   clear
    read -p "Introduce el nombre de usuario " nombre
# Check de si el usuario existe
    egrep "^$nombre" /etc/passwd >/dev/null 
# $? -eq 0 = si existe , $? -eq 1 = no existe
if [ $? -eq 0 ]; then
    read -p "Introduce un permiso para cambiar (Ej: 777, 640) " permiso
    re='^[0-9]{3}$'    # Validador de que tenga 3 números
else
    echo "Error, no existe el usuario "
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
fi
    if [[ $permiso =~ $re ]]; then
    chmod +$permiso $nombre
    echo "Se han actualizado los permisos "
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
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