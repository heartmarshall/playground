#! /bin/bash
meta_bytes=$(dd if="$1" count=1 bs=512 status=none| od -j446 -An -xv --endian=big 2>/dev/null) # если файл меньше 512б, то он и так не пройдет по дальнейшим проверкам
if ! echo "$meta_bytes" | tail -n1 | grep  -q "55aa"; then
  echo "No MBR signature found"
  exit 1
fi
echo "$meta_bytes" | head -n4 | cut -f4 -d' ' | grep -cve '0000'

# вообще можно было сделать через file "$1"| grep -oeE 'partition [0-4]' | wc -l но так не интересно)
