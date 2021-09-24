#! /bin/bash

curl -s 'https://www.7timer.info/bin/astro.php?lat=60&lon=30.4&product=astro&output=json&unit=metric' | grep 'temp2m' | tr -d '\t, '|sort -n | tail -n1 | cut -f2 -d ':'

