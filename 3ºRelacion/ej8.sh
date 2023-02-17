#!/bin/bash

# Hacer un script que muestre información legible por pantalla sobre el usuario activo en el sistema:

# Debe determinar: Nombre de usuario (obtenido de variable de sistema), Directorio de trabajo (obtenido de variable de sistema) y Shell asociada al usuario.
clear

echo "A continuación, se mostrará información sobre el usuario activo."

echo "Nombre de usuario: $USER"
echo "Directorio de trabajo: $HOME"
echo "Shell asociada al usuario: $SHELL"