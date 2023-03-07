#!/bin/bash

# Script al que se le pasa un fichero como argumento y muestra en pantalla y en ficheros el contenido cambiando lo siguiente:

# - R_minusculeas.txt -> contenido del fichero argumento pasado todo a minúsculas

# - R_mayusculas.txt -> contenido del fihero argumento pasado a mayúsculas.

# - R_sinA.txt -> contenido del fichero argumento eliminando todas las ocurrencias de la letra "a"

# - R_Vocales.txt -> contenido del fichero argumento, pasando todas las vocales a mayúsculas.

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para cambiar el contenido de un archivo de distintas maneras. Minúsculas a mayúsculas y viceversa , eliminando las letras A y pasando todas las vocales a mayúsculas."

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

# Verificar el número de argumentos
if [ $# -ne 1 ]; then
  echo "Número de argumentos incorrecto. Escriba los argumentos de siguiente manera: $0 <archivo>"
  exit 1
fi

# Verificar si el archivo existe
if [ ! -f $1 ]; then
  echo "El archivo no existe."
  exit 1
fi

# Transformar el contenido del archivo
cat $1 | tr '[:lower:]' '[:upper:]' > contenido_cambiado/R_mayusculas.txt
cat $1 | tr '[:upper:]' '[:lower:]' > contenido_cambiado/R_minusculas.txt
cat $1 | tr -d 'a' > contenido_cambiado/R_sinA.txt
cat $1 | sed 's/[aeiou]/\U&/g' > contenido_cambiado/R_Vocales.txt

# Mostrar el contenido transformado
echo "Contenido en mayúsculas:"
cat contenido_cambiado/R_mayusculas.txt
echo "Contenido en minúsculas:"
cat contenido_cambiado/R_minusculas.txt
echo "Contenido sin 'a':"
cat contenido_cambiado/R_sinA.txt
echo "Vocales en mayúsculas:"
cat contenido_cambiado/R_Vocales.txt