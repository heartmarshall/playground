#! /bin/bash

ls -la /dev | tr -s ' ' | cut -f1,10 -d ' ' | sed '1d' > tmp
sed -Ei 's/^[-].*/have type regular file/' tmp
sed -Ei 's/^[d].*/have type directory/' tmp
sed -Ei 's/^[b].*/have type block device/' tmp
sed -Ei 's/^[c].*/have type character device/' tmp
sed -Ei 's/^[l].*/have type link/' tmp
sed -Ei 's/^[s].*/have type socket/' tmp

ls -a /dev | sed -E 's/^([.]*)/\/dev\/\1/' > tmp_names

paste tmp_names tmp | sed 's/\t/ /'
rm tmp tmp_names

