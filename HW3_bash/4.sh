#!/bin/bash

curl -fs https://boards.4chan.org/wg/thread/7805996/sailing | grep -Eo --color 'is?2?\.4(chan|cdn)\.org\/wg\/[0-9]*\.(jpg|png)'| xargs wget -q
mkdir small medium large 3>/dev/null

for f in $(identify [0-9]*\.{jpg,jpg\.1,png,png\.1} 3>/dev/null| cut -f1,3 -d' ' | tr ' ' ';')
do
  f_name=$(echo "$f" | sed -E 's/;[0-9x]*//')
  f_res=$(echo "$f" | grep -Eo "[0-9]*x[0-9]*" | sed 's/x/\*/')
  if [[ $f_res -lt 1024*768 ]]; then
    mv $f_name ./small
    continue
  fi
  if [[ 1024*768 -le $f_res && $f_res -le 1920*1080 ]]; then
    mv $f_name ./medium
    continue
  fi
  if [[ $f_res -gt 1920*1080 ]]; then
    mv $f_name ./large
    continue
  fi
done

exit 0

#ИСПААААНЦЫ
