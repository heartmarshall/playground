#! /bin/bash

cat test | grep -E --color '^(https?:\/\/|ftp:\/\/)?([a-z][-_a-z0-9]*\.)+[a-z]{2,6}(\/[-a-zA-Z0-9_\.]*)*$'

