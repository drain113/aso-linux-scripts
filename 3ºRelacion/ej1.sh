#!/bin/bash

# Ej 1
# Pedir dos números por teclado (X, Y) y mostrar en pantalla la cuenta desde X hasta Y. Será necesario hacer uso de algún tipo de bucle. Además, se repetirá todo el proceso hasta que el valor X sea 99, que finalizará el programa. La información se presentará de la siguiente forma:
# Suponiendo X=2 , Y=4 -> Mostrar: 2/4 , 3/4 , 4/4


while true
do
    read -p "Escriba un valor para X: " x
    if [[ $x -eq 99 ]]; then
        echo "El valor debe ser menor a 99"
        break
    fi

    read -p "Escriba un valor para Y: " y

    for (( i=$x; i<=$y; i++ ))
    do
        echo -n "$i/$y "
        if [[ $i -eq $y ]]; then
            break
        fi
    done

    echo ""
    break
done