#! /bin/bash

lspci -v | grep -A10 VGA | grep 'Kernel driver in use:' | cut -f 2 -d ':'
