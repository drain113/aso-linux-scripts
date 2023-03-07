#!/bin/bash

# 3.- Realizar un script, que acepte como primer argumento un directorio y como segundo
# argumento un nombre de fichero y nos muestre en pantalla si existe el fichero dentro de
# ese directorio. En caso de que exista, nos debe preguntar si deseamos acceder a su
# contenido. En caso afirmativo nos mostrará el contenido en pantalla. Asegurar de que se
# trata de un fichero y no un subdirectorio.

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para mostrar contenido en pantalla de un directorio si existe."
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

read -p "Introduce el directorio " dir
read -p "Introduce el archivo " file

# Verificar si el directorio existe
if [ ! -d $dir ]; then
  echo "El directorio $dir no existe."
  exit 1
fi

# Verificar si el archivo existe en el directorio
if [ ! -f $dir/$file ]; then
  echo "El archivo $file no existe en el directorio $dir."
  exit 1
fi

# Preguntar si se desea acceder al contenido del archivo
echo "El archivo $file existe en el directorio $dir."
read -p "¿Desea acceder a su contenido? (s/n) " acceder

# Mostrar el contenido del archivo si se eligió "s"
if [ "$acceder" == "s" ]; then
  cat $dir/$file
fi