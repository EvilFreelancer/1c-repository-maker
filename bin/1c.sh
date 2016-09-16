#!/bin/bash

# Daemon fix
my_path="$(dirname $0)"
cd "$my_path"

# Include configs and functions
source config.sh
source functions.sh

#
# Stage 1 - Get all links and download
#
get_links "$SOURCE" | \
while read link; do download "$link" "$REPO_DEB" "$REPO_RPM"; done

#
# Stage 2 - Create the repositories
#
create_repo deb "$REPO_DEB"
create_repo rpm "$REPO_RPM"
