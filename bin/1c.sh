#!/usr/bin/env bash

# Daemon fix
my_path="$(dirname $0)"
cd "$my_path"

# Include configs and functions
source config.sh
source functions.sh

#
# Stage 1 - Get all links and download
#
get_links "$SOURCE" > "$REPO/last.txt"

# If we have two different files
if [ "$(cat "$REPO/last.txt")" != "$(cat "$REPO/prev.txt")" ]
    then
        cat "$REPO/last.txt" | while read link; do download "$link" "$REPO_DEB" "$REPO_RPM"; done
        cp "$REPO/last.txt" "$REPO/prev.txt"
        UPDATED=1
fi

#
# Stage 2 - Create or update the repositories
#
if [ "$UPDATED" == '1' ]
    then
        cp "$REPO/last.txt" "$REPO/prev.txt"

        echo "INF: Create DEB repo"
        create_repo deb "$REPO_DEB" "$my_path"
        echo "INF: Create RPM repo"
        create_repo rpm "$REPO_RPM" "$my_path"
    else
        echo "INF: Files is not changed"
fi
