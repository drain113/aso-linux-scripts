#!/bin/bash

# Script para buscar los scripts del directorio de un usuario

clear

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para encontrar los scripts del directorio home de un usuario."
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

contar_sh() {
  TOTAL=0

  for dir_home in /home/*; do
    if [ -d "$dir_home" ]; then
      USER=$(basename "$dir_home")
      # Busca los archivos con extensión .sh en el directorio home.
      CONTAR=$(find "$dir_home" -name "*.sh" | wc -l)
      if [ "$CONTAR" -gt 0 ]; then
        echo "Hay $TOTAL scripts en el directorio home"
      fi
    fi
  done
}

contar_sh_user() {
  read -p "Ingrese el nombre del usuario: " USER
  dir_user="/home/$USER"
  if [ -d "$dir_user" ]; then
    CONTAR=$(find "$dir_user" -name "*.sh" | wc -l)
    if [ "$CONTAR" -gt 0 ]; then
      echo "$USER: $CONTAR scripts de Bash."
    else
      echo "No se encontraron scripts de Bash para el usuario $USER."
    fi
  else
    echo "El usuario $USER no tiene una carpeta home."
  fi
}

# -------- Menú -------- 

while true; do
  echo "Seleccione una opción:"
  echo "1. Total de scripts del home global."
  echo "2. Total de scripts de un usuario."
  echo "3. Salir."
  read -p "Selecciona una opción (1-3): " OPTION
  clear
  case $OPTION in
    1) contar_sh;;
    2) contar_sh_user;;
    3) echo "Cerrando..."
      exit;;
  esac
done

# ----------------------