#!/bin/bash

# Crear copia de seguridad de todos los directorios del usuario y expulsar usuarios poniéndolos en nivel de seguridad 1.
# Se debe comprimir con tar y ejecutar el script todos los días a cierta hora (4 AM).

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

# Crear una copia de seguridad de todos los directorios del usuario, comprimiéndolo en un archivo tar
tar -cvzf backup_$fecha.tar.gz /home/$usuario/

# Expulsar a los usuarios, poniéndolos en nivel de seguridad 1
for i in $(users); do
  usermod -L $i
done

# Ejecutamos la copia de seguridad todos los días a las 4 a.m.
echo "0 4 * * * /bin/bash $PWD/copia_seguridad.sh" | crontab -