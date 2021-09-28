#!/bin/bash

if [[ $# -ne 2 && $# -ne 1 ]]; then
  echo "ERROR: Wrong amount of arguments" >&2
  exit 1;
fi

if [[ "$1" != "push" && "$1" != "pop" ]] ; then
  echo "ERROR: Wrong command. Stack supports only 'push' and 'pop'" >&2;
  exit 1
fi

if ! [[ -f /tmp/stack ]]; then
  if [[ $1 = "pop" ]]; then
    echo "ERROR: Can't pop from empty stack" >&2;
    exit 1
  fi
  touch /tmp/stack
fi

if [[ $1 = "push" ]]; then
  echo "$2" >> /tmp/stack
else
  tail -n1 /tmp/stack | xargs echo
  sed -i '$ d' /tmp/stack
  if [[ $(wc -l /tmp/stack | cut -f1 -d' ') -eq 0 ]]; then
    rm /tmp/stack
  fi
fi

exit 0
