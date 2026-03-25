#!/bin/bash

[[ -z $1 ]] && echo give a number and retry && exit

n=$1 ; factorial=1 ; j=1

while [[ $j -le $n ]]
do
    factorial=$(( $factorial* $j ))
    j=$(( $j + 1 ))
done
echo $n factorial \($n\!\) = $factorial

