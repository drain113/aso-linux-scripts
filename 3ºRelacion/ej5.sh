#!/bin/bash

# Empleando un array o lista, realizar un script que reciba como argumento un directorio e introduzca en un array todos los ficheros que cotiene el directorio introducido como argumento. A continuación se pedirá por teclado que se introduzca un número entre 1 y el número máximo de elementos que contiene el array. Mediante una llamada a función, devolverá en pantalla el nombre del archivo que ocupa la posición introducida en el número seleccionado y el número de caracteres que tiene. El proceso de pedir un número se ha de repetir hasta introducir el valor 0 (cero) 


# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para mostrar todos los ficheros en un arrayrecibiendo como argumento un directorio."
  echo "Además Mediante una llamada a función, devolverá en pantalla el nombre del archivo que ocupa la posición introducida en el número seleccionado y el número de caracteres que tiene. El proceso de pedir un número se ha de repetir hasta introducir el valor 0 (cero)"
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

# Verificar si se pasó un argumento
if [ $# -ne 1 ]; then
  echo "Número de argumentos incorrecto. Escriba el argumento de siguiente manera: $0 <directorio>"
  exit 1
fi

# Listado de archivos del directorio
archivos=("$1"/*)

# Función para obtener el nombre y el número de caracteres de un archivo en una posición dada
function get_file_name_and_length() {
  local index=$1
  local file="${archivos[$index]}"
  local name=$(basename "$file")
  local length=$(wc -c < "$file")
  echo "$name ($length caracteres)"
}

# Pedir un número hasta que se introduzca 0
while true; do
  read -p "Introduzca un número entre 1 y ${#archivos[@]} (0 para salir): " numero
  if [ "$numero" -eq 0 ]; then
    break
  elif [ "$numero" -lt 1 ] || [ "$numero" -gt "${#archivos[@]}" ]; then
    echo "Número no válido. Inténtelo de nuevo."
  else
    resultado=$(get_file_name_and_length "$((numero-1))")
    echo "El archivo en la posición $numero es: $resultado"
  fi
done
