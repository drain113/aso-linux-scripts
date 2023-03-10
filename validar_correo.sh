#!/bin/bash
 # Script para validar un correo electrónico según parametros declarados en el If.

clear

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para validar una dirección de correo electrónico."
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

# Validar correo
while true; do
  echo "Introduzca su dirección de correo:"
  read correo
  clear

  if [[ "$correo" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "$correo es un correo utilizable o válido."
    break
  else
    echo "$correo NO es un correo utilizable o válido."
  fi
done
exit 0