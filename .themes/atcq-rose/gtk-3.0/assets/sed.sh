#!/bin/sh
sed -i \
         -e 's/#3e4153/rgb(0%,0%,0%)/g' \
         -e 's/#CE7BB0/rgb(100%,100%,100%)/g' \
    -e 's/#282a36/rgb(50%,0%,0%)/g' \
     -e 's/#CE7BB0/rgb(0%,50%,0%)/g' \
     -e 's/#1d1f28/rgb(50%,0%,50%)/g' \
     -e 's/#CE7BB0/rgb(0%,0%,50%)/g' \
	"$@"
