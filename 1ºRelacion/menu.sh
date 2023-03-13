#!/bin/bash

# Menú con varias funciones, entre ellas:
# "1. Crear usuario "
# "2. Habilitar usuario "
# "3. Deshabilitar usuario "
# "4. Cambiar permisos a un usuario "
# "5. Copia de seguridad del directorio de trabajo de un usuario determinado "
# "6. Usuarios conectados actualmente "
# "7. Espacio libre en disco "
# "8. Trazar ruta hacia una dirección"



# --------- Función ayuda ---------

function ayuda {
  echo "Este script contiene un menú con distintas utilidades."
}

while getopts "h" opt; do
  case ${opt} in
    h ) # Mostrar ayuda
        ayuda
        exit 0;;
    \? ) # Exit 1 si la opción no es válida
         echo "ERROR: Opción no válida: -$OPTARG" 1>&2
         ayuda
         exit 1;;
  esac
done

# -----------------------------

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
    read -p "Introduce la ruta de la carpeta o archivo " ruta
# Check de si existe la ruta
    if [ ! -d "$ruta" ]; then
    echo "La ruta $ruta no existe, por favor introduzca una ruta correctamente."
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC

else
        read -p "Introduce un permiso para cambiar (Ej: 777, 640) " permiso
        re='^[0-9]{3}$'    # Validador de que tenga 3 números

    if [[ $permiso =~ $re ]]; then
        chmod +$permiso $ruta
        echo "Se han actualizado los permisos "
        read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
fi
fi

}

function copiaseguridad () {
clear
read -p "Introduce el nombre de usuario " nombre
# Check de si el usuario existe
    egrep "^$nombre" /etc/passwd >/dev/null 
# $? -eq 0 = si existe , $? -eq 1 = no existe
if [ $? -ne 0 ]; then
    echo "El usuario $nombre no existe, por favor pulsa 1 en el menú para crearlo"
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC

    else
        echo "Creando una carpeta de copias de seguridad para el usuario $nombre en /copiaseguridad/ "
        mkdir /copiaseguridad/
        cp -r /home/$nombre /copiaseguridad/
        echo "Se ha guardado una copia de seguridad existosa"
        read -p "Introduce otra opción (pulsa cualquier tecla) " OPC

fi
}

function conectados () {
clear
    echo "A continuación se muestran los usuarios conectados"
    w -hu
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
}

function espaciolibre () {
clear
    echo "A continuación se muestra el espacio en disco libre"
    df -H
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
}

function traceroute () {
    read -p "Introduce una dirección IP para trazar su ruta " ip
    # Validar IP
    until [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] 
    do
    echo "ERROR: Por favor, introduzca una IP con la sintáxis correcta"
    read -p "Introduce una dirección IP para trazar su ruta " ip
    done
    echo "Trazando la ruta de la ip $ip "
    command traceroute $ip
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
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
