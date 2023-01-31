#!/bin/bash
clear
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

  # Haz múltiples pings a la IP actual
  response=$(ping -c 4 $ip | grep "received" | awk -F',' '{ print $2 }' | awk '{ print $1 }')

  # Si la respuesta es mayor a 0, la IP está en uso
  if [ $response -gt 0 ]; then
    echo $ip is in use
  fi
done


else
echo "ERROR: Por favor, introduzca una IP con la sintáxis correcta"
exit 1
fi
