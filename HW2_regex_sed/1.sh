#! /bin/bash

cat test | grep -E '^[+-]?([1-9]|[1-9]\.[0-9]+)[eE][+-]?(0|[1-9][0-9]*)$
