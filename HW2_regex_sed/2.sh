#! /bin/bash

cat test | grep -E '^\+[1-9][0-9]{0,2}([0-9]{2,3}|\([0-9]{2,3}\))([0-9]{7}|[0-9]{3}-[0-9]{2}-[0-9]{2})$'

