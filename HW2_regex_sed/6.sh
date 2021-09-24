#! /bin/bash

cat test | grep -E --color '^(xx+)\1+$'

