#!/bin/bash

# Leer la pulsación de una tecla y decir si la tecla pulsada es un número o una letra, o no es ni número ni letra. El proceso se repetirá hasta introducir la tecla intro.

while true; do
    read -n 1 -p "Introduce una tecla (pulsa Enter para salir): " tecla
    echo ""

    if [[ -z $tecla ]]; then
        # Salir del bucle al pulsar enter
        break
        # Checkear si es un número
    elif [[ $tecla =~ [0-9] ]]; then
        echo "La tecla pulsada es un número."
        # Checkear si es una letra
    elif [[ $tecla =~ [[:alpha:]] ]]; then
        echo "La tecla pulsada es una letra."
    else
        echo "La tecla pulsada no es ni número ni letra."
    fi
done