#!/bin/bash

# Hacer un script que diga por pantalla buenos días, buenas tardes o buenas noches según la hora del sistema.

# En este caso, Desde las 6:00 AM hasta las 11:59 AM , será "Buenos días"
# Desde las 12:00 AM hastá las 19:59 PM será "Buenas tardes"
# Desde las 20:00 PM hasta las 5:99 AM será "Buenas noches"

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