#! /bin/bash

dmesg > tmp
grep 'systemd' tmp > systemd.log
rm tmp
