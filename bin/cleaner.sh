#!/usr/bin/env bash

# Daemon fix
my_path="$(dirname $0)"
cd "$my_path"

# Include configs and functions
source config.sh
source functions.sh

# Incoming argv count test
if [ $# -lt 2 ]
then
 echo "./script <mode> <count> <update_y/n>"
 exit
fi

x=1         # For increment
mode=$1     # Filename mask
keep=$2     # Exclude latest {count} files

#
# Stage 1 - Select values by mode
#
case $mode in
    "deb")
        path=$REPO_DEB
        filemask="*.deb"
        ;;
    "rpm")
        path=$REPO_RPM
        filemask="*.rpm"
        ;;
    *)
        echo "ERR: Wrong mode, only 'deb' or 'rpm' is available"
        exit
        ;;
esac

#
# Stage 2 - Remove the old files
#
ls -t $path/$filemask | \
while read filename
    do
        if [ $x -le $keep ]
            then
                x=$(($x+1))
                continue
        fi
        echo "INF: Remove $filename"
        rm $filename
done
