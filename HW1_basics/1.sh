#! /bin/bash

mkdir -p task1/biggest_etс task1/smallest_etc

cp `find /etc -type f | xargs du -ba  | sort -nrk 1 | head -n 10| cut -f 2` ./task1/biggest_etс/

cp `find /etc -type f | xargs du -ba  | sort -nk 1 | head -n 10| cut -f 2` ./task1/smallest_etc/

