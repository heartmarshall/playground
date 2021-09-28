#!/bin/bash

function clean_tmp() {
  rm /tmp/ps_tmp /tmp/PID_list /tmp/users_list
}

if [[ $# -gt 6 ]]; then
  echo "ERROR: Wrong amount of arguments" >&2
  exit 1
fi

touch /tmp/ps_tmp
find /proc/ -maxdepth 1 -type d  -regex "/proc/[0-9]+" -printf "%f\n" > /tmp/PID_list
cut -f1,3 -d':' /etc/passwd > /tmp/users_list # получаем список пользователей имя:ID
for pid in $(cat /tmp/PID_list)
do
  if [[ -f "/proc/$pid/status" ]] ;  then
    uid=$(grep "Uid:" "/proc/$pid/status" | tr -s ' ' | cut -f2)
  else
    continue
  fi
  user=$(grep -E "\:$uid$" "./tmp/users_list" | sed -E 's/:[0-9]*//')
  cmdline=$(cat /proc/$pid/cmdline | tr -d '\0')
  if [[ $cmdline = "" ]]; then
    cmdline=$(echo "[kernel]")
  fi
  echo -e "$pid\t$user\t$cmdline" >> /tmp/ps_tmp
done

if [[ -z $* ]]; then
	cat /tmp/ps_tmp
fi

while getopts "puc" opt; do
  case $opt in
    p) grep -P "^$2\t" /tmp/ps_tmp || echo "ERROR: The process with the requested ID does not exist" >&2; clean_tmp; exit 1;;
    u) grep -P "\t$2\t" /tmp/ps_tmp || echo "ERROR: No processes found for the requested user" >&2; clean_tmp; exit 1;;
    c) grep -P "^[0-9]*\t[^\t \n]*\t[^ \t\n]*$2[^ \t\n]*$" /tmp/ps_tmp;;
  esac
done

clean_tmp
exit 0
