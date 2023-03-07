#!/bin/bash

# Mediante tres argumentos (solo tres), pasar tres nombres de ficheros sobre los que se mostrará en pantalla y en fichero recibido como tercer argumento, las diferencias de los dos primeros ficheros, incluidos los números de línea.

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para diferenciar dos archivos mostrándose como un fichero determinado como tercer argumento."
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
if [ $# -ne 3 ]; then
    echo "Número de argumentos incorrecto. Escriba los argumentos de siguiente manera: $0 <fichero1> <fichero2> <fichero_salida>"
    exit 1
fi


# Verificar si los dos primeros archivos existen
if [ ! -f "$1" ]; then
    echo "El archivo '$1' no existe."
    exit 1
fi

if [ ! -f "$2" ]; then
    echo "El archivo '$2' no existe."
    exit 1
fi


# Diferencias de los dos archivos por pantalla y en archivo
diff -u "$1" "$2" | tee "$3"

echo "Las diferencias de '$1' y '$2' se han guardado en '$3'."