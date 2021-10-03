#!/bin/bash

touch /tmp/fib
echo "0
1
1" > /tmp/fib

if [[ $# -ne 1 ]]; then
  echo "ERROR: Wrong amount of arguments" >&2
  exit 1;
fi

re='^[1-9][0-9]*$'
if ! [[ $1 =~ $re ]] ; then
   echo "ERROR: Wrong type input" >&2;
  exit 1
fi

for (( n = 3; n < $1; n++ )); do
    V1=$(tail -n2 /tmp/fib | sed -n '1p')
    V2=$(tail -n2 /tmp/fib | sed -n '2p')
    V3=$((V1+V2))
    echo $V3 >> /tmp/fib
done

sed -n "$1 p" /tmp/fib
rm /tmp/fib
