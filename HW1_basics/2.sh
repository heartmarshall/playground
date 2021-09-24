#! /bin/bash

grep -l 'bash' `find /etc -type f 2>/dev/null` 2>/dev/null | xargs du -acb | tail -n 1 | cut -f 1

