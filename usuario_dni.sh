#!/bin/bash
clear 

# Crear un nombre de usuario determinado por su primera letra del nombre, tres primeras del apellido y dos últimos dígitos del DNI
# Esta información debe ser dada desde un archivo

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para crear un nombre de usuario mediante su nombre, apellido y DNI."


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
}
# -----------------------------


# Fichero de entrada
echo "Ingrese el nombre del archivo de entrada (formato: nombre;apellido;DNI): "
read input_file

# Verificar que el archivo de entrada existe
if [ ! -f $input_file ]; then
  echo "El archivo de entrada no existe."
  exit 1
fi

# Fichero de salida
echo "Ingrese el nombre del archivo de salida:"
read output_file

# Verificar que el archivo de salida no existe
if [ -f $output_file ]; then
  echo "El archivo de salida ya existe. Por favor, ingrese un nombre diferente."
  exit 1
fi

# Iterando sobre las lineas del archivo de entrada
while IFS=';' read -r name last_name dni; do

  # Primera letra del nombre
  first_letter=${name:0:1}

  # Tres primeras letras del apellido
  first_letters_lastname=${last_name:0:3}

  # Dos últimos dígitos del DNI
  last_two_digits=${dni: -2}

  echo "$first_letter$first_letters_lastname$last_two_digits" >> $output_file

done < $input_file

echo "Se ha creado el archivo correctamente. "