#! /bin/bash

mkdir task7
cd ./task7

wget https://gist.githubusercontent.com/phillipj/4944029/raw/75ba2243dd5ec2875f629bf5d79f6c1e4b5a8b46/alice_in_wonderland.txt 

cat alice_in_wonderland.txt | wc -l > statistics
cat alice_in_wonderland.txt | wc -w >> statistics
grep -io --color "alice" alice_in_wonderland.txt | wc -w >> statistics
grep -i "alice" alice_in_wonderland.txt | wc -l >> statistics
grep --color -Eo "[a-zA-Z]+['-]?[a-zA-Z]+" alice_in_wonderland.txt | sort | uniq -c | sort -k 1 -n | tail -n 10 >> statistics

cat alice_in_wonderland.txt | tr "A-Z" "a-z" > alice.txt
cat alice_in_wonderland.txt | tr "a-z" "A-Z" > ALICE.txt

shuf -n10 alice_in_wonderland.txt > alice_shuf.txt

cd ..

