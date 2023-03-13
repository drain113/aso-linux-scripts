#!/bin/bash

# Pedir un valor númerico por teclado y aplicar la siguiente fórmula,sabiendo que el valor introducido es la "x" y lo que se pretende calcular es "Resultado"
# Resultado = 3x²+5x+8

# --------- Función ayuda ---------

function ayuda {
  echo "Este script sirve para aplicar la fórmula de 3x²+5x+8 dónde X es el valor a introducir."
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

read -p "Introduce el valor de X: " x

# Calcular con la fórmula dada
resultado=$((3*x*x + 5*x + 8))

# Resultado
echo "3($x)²+5($x)+8 = $resultado"
