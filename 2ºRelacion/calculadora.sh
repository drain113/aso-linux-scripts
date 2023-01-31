#!/bin/bash

# 1.- Programar un script que acepte tres argumentos: operando1 operando2 operador, con
# el objetivo de construir una calculadora “postorden”, donde el tercer argumento es la
# operación a realizar (+,-,*,/) sobre los dos primeros argumentos. El resultado será
# mostrado por pantalla de la siguiente forma, por ejemplo:
# “Se ha realizado la operación: 3 + 5 = 8”

clear

# Introducir tres parámetros
re='^[0-9]+$' # Validador de números

read -p "Introduce el primer operando " op1
if [[ $op1 =~ $re ]]; then
read -p "Introduce el segundo operando " op2
else
  echo "Introduce un número entero correctamente ."
  exit 1
fi

if [[ $op2 =~ $re ]]; then
read -p "Indica la operación (+, -, *, /) " operador
else
  echo "Introduce un número entero correctamente ."
  exit 1
fi

if [ "$operador" == "+" ]; then
  resultado=$(($op1 + $op2))
elif [ "$operador" == "-" ]; then
  resultado=$(($op1 - $op2))
elif [ "$operador" == "/" ]; then
  resultado=$(($op1 / $op2))
elif [ "$operador" == "*" ]; then
  resultado=$(($op1 * $op2))
else
  echo "Operador no válido"
  exit 1
fi

echo "El resultado es: $resultado"

#!/bin/bash



