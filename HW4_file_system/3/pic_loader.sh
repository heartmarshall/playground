#! /bin/bash

function sort_images() { # сотирует по размеру изображения в заданной папке
  for f in $(identify $storage_dir\/[0-9]*\.{jpg,png} | cut -f1,3 -d' ' | tr ' ' ';')
  do
    f_name=$(echo "$f" | cut -f1 -d';')
    f_res=$(echo "$f" | cut -f2 -d';' | sed 's/x/\*/')
    if [[ $f_res -lt 1024*768 ]]; then
      mv "$f_name" $storage_dir/small/
      continue
    elif [[ $f_res -gt 1920*1080 ]]; then
      mv "$f_name" $storage_dir/large/
    else
      mv "$f_name" $storage_dir/medium/
    fi
  done
  # TODO возможно нужно заменить сравнение строк на сравнение чисел
}


function format_link() { # преобразует относительные ссылки в абсолютные
  if [[ $(echo "$1" | grep -E "(http:|https:|^\/\/)") ]]; then
    echo "обрабатывается файл: $1" >&0
    echo "$1" | sed 's/^\/\///'
  else
    if [[ $(echo "$1" | grep -E "^\/") ]]; then
      echo "$(echo "$download_link" | grep -oE "^(http:\/\/|https:\/\/)?[^\/: \n]*")$1" # НЕ тестировал
    else
      echo "$download_link$1"
    fi
  fi
}


while true; do
  ! [[ -f /etc/pic_loader/dir && -f /etc/pic_loader/link ]] && continue

  download_link=$(cat "/etc/pic_loader/link") # Идея: можно добавить режим обработки сразу нескольких ссылок
  storage_dir=$(cat "/etc/pic_loader/dir")
  mkdir  -p "$storage_dir"/{small,medium,large}

  links=$(curl -fs "$download_link" |  grep -Po "<a[^>]*href=\"[^>]*\.(jpg|png)\"[^>]*>[^<>]*<\/a>" | grep -Eo "href=\"[^\"]*\"" | sed -E 's/href="([^"]*)"/\1/') # Ищем на сайте все ссылки, ведущие на изображения с форматом jpg и png
  founded_files=$(echo "$links" | grep -Eo "[^\/]*\.(png|jpg)")
  existing_files=$(ls $storage_dir/{small,medium,large} | sed -E '/.*:$/d') # Идея: можно вынести имена существующих изображений в отдельный файл, а затем просто дописывать туда новые имена

  for file_name in $(echo -e "$existing_files\n$existing_files\n$founded_files" | sort | uniq -u)
  do
    format_link "$(echo "$links" | grep "$file_name")" | xargs wget -qP "$storage_dir"/
  done
  sort_images

  sleep 60
done
