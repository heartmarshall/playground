!# /bin/bash

sudo find . -type f -perm /a=x | xargs chmod a-x

