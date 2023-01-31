#!/bin/bash
function dar_permiso () {
    read -p "Introduce un directorio para dar permisos de ejecución " dar_dir
    chmod +x $dar_dir/*
    echo "Se han dado los permisos de manera exitosa. "
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
}

function quitar_permiso () {
    read -p "Introduce un directorio para dar permisos de ejecución " dar_dir
    chmod -x $dar_dir/*
    echo "Se han quitado los permisos de manera exitosa. "
    read -p "Introduce otra opción (pulsa cualquier tecla) " OPC
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

function 20recientes () {
clear
out_file="20inicios.txt"

# Eliminar el archivo de salida anterior si existe
if [ -f $out_file ]; then
  rm $out_file
fi

# Obtener los 20 inicios de sesión más recientes y escribirlos en el archivo de salida
last | head -n 20 > $out_file

        echo "Se ha guardado un archivo con los inicios de sesión en su directorio actual. "
        read -p "Introduce otra opción (pulsa cualquier tecla) " OPC

}








#----------------------------------------------------------------------------------------
OPC="0"
until [ $OPC = "5" ]; do
    clear
    echo "[ Seleccione una opción]"
    echo "1. Dar permiso de ejecución a todos los archivos de un directorio "
    echo "2. Quitar permiso de ejecución a todos los archivos de un directorio "
    echo "3. Hacer copia de seguridad del directorio de trabajo de un usuario "
    echo "4. Obtener en un archivo los 20 inicios de sesión más recientes "
    echo "5. Salir "
    read -p "Eliga una opción (1,2,3,4,5) " OPC
    echo " "
    case $OPC in
        1) dar_permiso;;
        2) quitar_permiso;;
        3) copiaseguridad;;
        4) 20recientes;;
        5) echo " Saliendo ";;
    esac
done
#----------------------------------------------------------------------------------------