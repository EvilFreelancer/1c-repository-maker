#!/bin/bash

# Downloadable link
link="$1"

# Extract file extension and name
ext="${link##*.}"
file="$(basename "$link")"

# Choose the mode
case "$ext" in
    "deb") dst="$2" ;;
    "rpm") dst="$3" ;;
    *) echo "ERR: Wrong extension. Exit." && exit ;;
esac

# Check if file is exist
if [ -e "$dst/$file" ]
    then
        echo "INF: In $(realpath "$dst") found $file"
    else
        echo "INF: Download $file"
        wget "$link" -P "$dst" 2>/dev/null
fi
