#!/bin/bash

# Determinar los números primos entre dos números dados como argumentos

clear

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para determinar los números primos entre dos."


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

if [ $# -ne 2 ]; then
  echo "ERROR: Por favor, introduce dos argumentos (números)."
  ayuda
  exit 1
fi

# Determinar argumentos como variables
num1=$1
num2=$2

# Checkear argumentos

# Que sea número entero
if ! [[ $num1 =~ ^[0-9]+$ ]] || ! [[ $num2 =~ ^[0-9]+$ ]] || [ $num1 -lt 0 ] || [ $num2 -lt 0 ]; then
  echo "Por favor, introduce un número entero."
  ayuda
  exit 1
fi

# Que el primero numero sea menor / igual al segundo
if [ ! $num1 -le $num2 ]; then
  echo "Error: El primer número debe ser menor o igual que el segundo número."
  ayuda
  exit 1
fi

# Checkear si es primo

function primo {
  if [ $1 -lt 2 ]; then
    return 1
  fi
  for (( i=2; i<$1; i++ )); do
    if [ $(($1%i)) -eq 0 ]; then
      return 1
    fi
  done
  return 0
}

# Recorremos los números entre num1 y num2 y verificamos si son primos
for (( i=$num1; i<=$num2; i++ )); do
  if primo $i; then
    echo $i
  fi
done