#!/bin/bash

# Hacer un script que diga por pantalla buenos días, buenas tardes o buenas noches según la hora del sistema.

# En este caso, Desde las 6:00 AM hasta las 11:59 AM , será "Buenos días"
# Desde las 12:00 AM hastá las 19:59 PM será "Buenas tardes"
# Desde las 20:00 PM hasta las 5:99 AM será "Buenas noches"

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para decir por pantalla buenos días, buenas tardes o buenas noches según la hora del sistema."

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


# Establecemos la variable hora
hora=$(date +%H)

# If para determinar los buenos días,tardes o noches según la hora
if [ $hora -ge 6 -a $hora -lt 12 ]
then
  echo "Buenos días"
elif [ $hora -ge 12 -a $hora -lt 20 ]
then
  echo "Buenas tardes"
else
  echo "Buenas noches"
fi
