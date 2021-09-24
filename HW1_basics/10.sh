#! /bin/bash

ls -lt --full-time `find /usr/bin -type f` | tail -n1 | tr -s ' ' | cut -f 6 -d ' ' | xargs date -d | cut -f 1 -d ' '

