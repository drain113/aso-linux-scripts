#!/bin/bash

# Crear copia de seguridad de todos los directorios del usuario y expulsar usuarios poniéndolos en nivel de seguridad 1.
# Se debe copiar con rsync y ejecutar el script todos los días a cierta hora (4 AM).

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para crear una copia de seguridad del directorio de usuario con rSync."
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

fecha=$(date +%Y-%m-%d_%H-%M-%S)

read -p "Introduce el usuario para crear la copia " usuario
# Check de si el usuario existe
    egrep "^$usuario" /etc/passwd >/dev/null 
# $? -eq 0 = si existe , $? -eq 1 = no existe
if [ $? -ne 0 ]; then
    echo "El usuario $usuario no existe "
    exit 1

else
echo "Guardando copia de seguridad en /copias/"

# Crear una copia de seguridad de todos los directorios del usuario, copiándolos con rsync
rsync -a /home/"$usuario" /copias/backup_"$fecha"

# Expulsar a los usuarios, poniéndolos en nivel de seguridad 1
for i in $(users); do
  usermod -L $i
done

# Ejecutamos la copia de seguridad todos los días a las 4am
echo "0 4 * * * /bin/bash $PWD/copia_seguridad.sh" | crontab -
