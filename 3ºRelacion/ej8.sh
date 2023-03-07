#!/bin/bash

# Hacer un script que muestre información legible por pantalla sobre el usuario activo en el sistema:

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para mostrar información legible por pantalla sobre el usuario activo en el sistema."

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

# Debe determinar: Nombre de usuario (obtenido de variable de sistema), Directorio de trabajo (obtenido de variable de sistema) y Shell asociada al usuario.
clear

echo "A continuación, se mostrará información sobre el usuario activo."

echo "Nombre de usuario: $USER"
echo "Directorio de trabajo: $HOME"
echo "Shell asociada al usuario: $SHELL"