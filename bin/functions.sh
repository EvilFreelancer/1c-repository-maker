#!/usr/bin/env bash

# Download page with links
function get_links()
{
    wget "$1" -O - 2>/dev/null | \
        grep '<a href="https://1cfresh.com/downloads' | \
        awk -F \" '{print $4}'
}

# Download packages
function download()
{
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
}

# Generate the repository files
function create_repo()
{
    # Destination
    dst="$2"

    # Choose the mode
    case "$1" in
        "deb")
            cd "$2"
            dpkg-scanpackages --multiversion . /dev/null | gzip -9c > Packages.gz
            cd "$3"
            ;;
        "rpm")
            cd "$2"
            createrepo --database .
            cd "$3"
            ;;
        *)
            echo "ERR: Wrong extension. Exit." && exit
            ;;
    esac
}
