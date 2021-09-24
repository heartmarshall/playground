#! /bin/bash

sort file1 | uniq > unite
sort file2 | uniq >> unite
cat unite > tmp
sort tmp | uniq > unite
rm tmp

sort unite | uniq -D | uniq > intersection

sort file1 | uniq > difference
cat intersection >> difference
sort difference | uniq -u > tmp4
cat tmp4 > difference
rm tmp4

