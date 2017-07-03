#!/bin/bash

# Daemon fix
my_path="$(dirname $0)"
cd "$my_path"

# Include configs and functions
source config.sh

#
# Stage 1 - Get all links and download
#
./get_links.sh "$SOURCE" | \
    while read link
        do
            ./download.sh "$link" "$REPO_DEB" "$REPO_RPM"
    done

#
# Stage 2 - Run cleaner
#
if [ "x$AUTOCLEAN" == "x1" ]
    then
        echo "INF: Clean old .deb packages"
        ./cleaner.sh deb 12

        echo "INF: Clean old .rpm packages"
        ./cleaner.sh rpm 12
fi

#
# Stage 3 - Create or update the repositories
#
echo "INF: Create DEB repo"
./create_repo.sh deb "$REPO_DEB" "$my_path"

echo "INF: Create RPM repo"
./create_repo.sh rpm "$REPO_RPM" "$my_path"
