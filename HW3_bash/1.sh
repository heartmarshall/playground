#!/bin/bash

touch ./tmp/fib
echo "1
1" > ./tmp/fib

if [[ condition ]]; then
  #statements
fi

for (( n = 2; n < $1; n++ )); do
    V1=$(cat ./tmp/fib | tail -n2 | sed -n '1p')
    V2=$(cat ./tmp/fib | tail -n2 | sed -n '2p')
    V3=$((V1+V2))
    echo $V3 >> ./tmp/fib
done

cat ./tmp/fib | tail -n1
