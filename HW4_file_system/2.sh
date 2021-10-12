#! /bin/bash

for file in $(find $1 -maxdepth 1 -type b,f ); do
  meta_bytes=$(dd if="$file" count=1 bs=512 status=none| od -j446 -An -xv --endian=big 2>/dev/null) # если файл меньше 512б, то он и так не пройдет по дальнейшим проверкам

  if ! echo "$meta_bytes" | tail -n1 | grep  -q "55aa"; then
    echo "$file has no MBR"
    continue
  fi

  partitions_counter=0
  founded_types=""
  for partition_code in $(echo "$meta_bytes" | cut -f4 -d' ' | sed -E 's/(..)../\1/'); do
    if ! [[ partition_code -eq "00" ]]; then
      ((partitions_counter++))
      founded_types+="$(grep "^$partition_code\h" ./partitions_codes_transcript | cut -f2), "
    fi
  done

  if [[ $partitions_counter -eq 0 ]]; then
    echo "$file has no partition"
    continue
  elif [[ $partitions_counter -eq 1 ]]; then
    echo "$(echo "$file has $partitions_counter partition with type: $founded_types" | sed "s/, $//")"
  else
    echo "$(echo "$file has $partitions_counter partitions with types: $founded_types" | sed "s/, $//")"
  fi

done
