#!/bin/bash

# Script para escanear direcciones IP y saber si están en uso o no.

clear

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para escanear direcciones IP para saber si están en uso."
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

ip=$1
# Validar IP
if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then 

# Dividir la IP en sus 4 segmentos
segment1=$(echo $ip | cut -d . -f 1)
segment2=$(echo $ip | cut -d . -f 2)
segment3=$(echo $ip | cut -d . -f 3)

# Itera a través de todas las IPs en la subred
for i in {1..255}
do
  # Construye la dirección IP actual
  ip="$segment1.$segment2.$segment3.$i"

  # Escanear todas las IP
  response=$(ping -W 0.09 -c 1 $ip | grep "received" | awk -F',' '{ print $2 }' | awk '{ print $1 }')

  # Si la respuesta es mayor a 0, la IP está en uso
  if [ $response -gt 0 ]; then
    echo $ip está en uso && echo $ip está en uso >> red-$1.txt
  else
    echo $ip no está en uso && echo $ip no está en uso >> red-$1.txt
  fi
done


else
echo "ERROR: Por favor, introduzca una IP con la sintáxis correcta"
exit 1
fi
