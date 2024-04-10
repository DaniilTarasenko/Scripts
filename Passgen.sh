#!/bin/bash

password() {
    result=""
    length=$1
    for (( i=0; i<$length; i++ ))
    do
        num=$(($(date +%N) & 126))
        if [ $num -lt 33 ]
        then
            num=$(($num + 33 & 126))
        fi
        char=$(printf \\x$(printf '%x' $num))
        result+=$char
        sleep 1
    done
    echo $result
}

echo "How long do you want your password to be?"
read -p "Length of password: " length_pas

for i in {1..5}
do
    password $length_pas
done
