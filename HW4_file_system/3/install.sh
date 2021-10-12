#! /bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root" >&2
  exit 1
fi

cp pic_loader.sh /usr/bin/
cp pic_loader.service /etc/systemd/system/

