#!/bin/bash

# Se necesita obtener el listado del directorio actual ordenado por nombre de fichero, en un fichero pasado como argumento y de forma que exista un separador de campos (dos puntos :)

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para obtener el listado del directorio actual ordenado por nombre de fichero, en un fichero pasado como argumento."
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
    echo "Número de argumentos incorrecto. Escriba el argumento de siguiente manera: $0 <fichero_a_listar>"
    exit 1
fi

# Obtener el listado de archivos ordenado por nombre
ls | sort > "$1"

# Separador de campos
sed -i 's/:/::/g' "$1"

echo "La lista de elementos del directorio actual se ha guardado en '$1'"