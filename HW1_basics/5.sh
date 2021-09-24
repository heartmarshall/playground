#! /bin/bash

mkdir task5
DIR="./task5/"
for USER in `cut -d : -f 1 /etc/passwd`; do
    mkdir "$DIR$USER" 2>/dev/null
done

