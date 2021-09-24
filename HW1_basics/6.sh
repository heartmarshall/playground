#! /bin/bash

du -h `find /usr/bin -type f` | sort -k1 -h | tail -n100 | cut -f2 | xargs ls -lt --full-time | tr -s ' ' | tail -n1 | cut -f9 -d ' '
