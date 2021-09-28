#! /bin/bash

ARR_TEST=(pen ‘exercise book’ «textbook» ruler 42 pencil)
ARR_TEST[$2]=$1
for (( i = 0; i < ${#ARR_TEST[@]}; i++ )); do
  echo "${ARR_TEST[i]}"
done
echo "export PROJECT=$ARR_TEST" > savedvars
