#!/bin/bash

if [[ $# -ne 2 && $# -ne 1 ]]; then
  echo "ERROR: Wrong amount of arguments" >&2
  exit 1
fi

if [[ "$1" != "push" && "$1" != "get" ]] ; then
  echo "ERROR: Wrong command. LRU cache supports only 'push' and 'pop'" >&2;
  exit 1
fi

if ! [[ -f /tmp/lru_cache ]]; then # создание файла кэша в случае его отсутствия.
  touch /tmp/lru_cache
fi

#узнаем сколько строк сейчас хранится в кэше
cur_cache_size=$(wc -l /tmp/lru_cache | cut -f1 -d' ')

if [[ $1 = "push" ]]; then # Обработка push-запроса. Сначала смотрим размер строки, затем проверяем влезет ли она в кэш.
  pushing_str_size=$(echo "$2" | wc -l  | cut -f1 -d' ')
  if [[ $(($cur_cache_size + $pushing_str_size)) < $LRU_SIZE ]]; then
    echo "$2" >> /tmp/lru_cache
  else
    if [[ $pushing_str_size -le $LRU_SIZE ]]; then
      for (( i = 0; i < $(($cur_cache_size + $pushing_str_size - $LRU_SIZE)); i++ )); do
        sed -i '1d' /tmp/lru_cache
      done
      echo "$2" >> /tmp/lru_cache
    else
      echo "ERROR: String size exceeds the allowed cache size " >&2
      exit 1
    fi
  fi
  exit 0

else # Обработка get-запроса.
  if ! [[ $(grep "$2" /tmp/lru_cache) ]]; then
    exit 1
  else
    match=$(grep "$2" /tmp/lru_cache| head -n1)
    sed -i "$(grep -n "$2" /tmp/lru_cache | cut -f1 -d':' | head -n1)d" /tmp/lru_cache
    echo "$match" >> /tmp/lru_cache
    echo "$match"
  fi
fi

exit 0
