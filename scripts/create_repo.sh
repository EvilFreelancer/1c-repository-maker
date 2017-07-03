#!/bin/bash

# Destination
dst="$2"

# Choose the mode
case "$1" in
    "deb")
        cd "$2"
        dpkg-scanpackages --multiversion . /dev/null | gzip -9c > ./Packages.gz
        cd "$3"
        ;;
    "rpm")
        createrepo --database "$2"
        ;;
    *)
        echo "ERR: Wrong extension. Exit." && exit
        ;;
esac
