#!/bin/bash

#Ej 2
# Script que recibe un argumento y hará lo siguiente:
# - Comprobará el número de argumentos recibidos, si es distinto de 1, mostrará en pantalla "Número de argumentos incorrecto" y muestre a continuación un mensaje de cómo hacer uso del script.

# - Si existe el fichero, se mostrará en pantalla su contenido, con las líneas numeradas.

# - Mostrará al final, el número de líneas totales del fichero, el número de palabras y el número de caracteres que cotiene el fichero

# --------- Función ayuda ---------

function ayuda {
  echo "Este script recibe un fichero como argumento, mostrará su contenido, el final, número de lineas, número de palabras y número de caracteres."
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

# Verificar el número de argumentos
if [ $# -ne 1 ]; then
    echo "Número de argumentos incorrecto. Escriba los argumentos de siguiente manera: $0 <nombre_de_archivo>"
    exit 1
fi

# Verificar si existe el archivo
if [ ! -f "$1" ]; then
    echo "Introduce un archivo correcto."
    exit 1
fi

# Mostrar el contenido del archivo con las líneas numeradas
nl "$1"

# Mostrar el número de líneas, palabras y caracteres del archivo
lineas=$(wc -l < "$1")
palabras=$(wc -w < "$1")
caracteres=$(wc -c < "$1")
echo "El archivo '$1' contiene $lineas líneas, $palabras palabras y $caracteres caracteres."