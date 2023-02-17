#!/bin/bash

# Pedir un valor númerico por teclado y aplicar la siguiente fórmula,sabiendo que el valor introducido es la "x" y lo que se pretende calcular es "Resultado"
# Resultado = 3x²+5x+8

read -p "Introduce el valor de X: " x

# Calcular con la fórmula dada
resultado=$((3*x*x + 5*x + 8))

# Resultado
echo "El resultado es: $resultado"