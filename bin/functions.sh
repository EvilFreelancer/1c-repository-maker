#!/usr/bin/env bash

# Download page with links
function get_links()
{
    wget "$1" -O - 2>/dev/null | \
        grep 'var\ platformversionstring' | \
        awk -F \' '{print $2}' | sed -r 's/\ /\n/g' | \
        while read version
            do
                version=`echo "$version" | sed -r 's/^(.*)\.(.*)\.(.*)\.(.*)/\1\.\2\.\3\-\4/g'`

                echo "https://1cfresh.com/downloads/platform/1c-enterprise83-thin-client_${version}_i386.deb"
                echo "https://1cfresh.com/downloads/platform/1c-enterprise83-thin-client_${version}_amd64.deb"
                echo "https://1cfresh.com/downloads/platform/1c-enterprise83-thin-client-nls_${version}_i386.deb"
                echo "https://1cfresh.com/downloads/platform/1c-enterprise83-thin-client-nls_${version}_amd64.deb"

                echo "https://1cfresh.com/downloads/platform/1C_Enterprise83-thin-client-${version}.i386.rpm"
                echo "https://1cfresh.com/downloads/platform/1C_Enterprise83-thin-client-${version}.x86_64.rpm"
                echo "https://1cfresh.com/downloads/platform/1C_Enterprise83-thin-client-nls-${version}.i386.rpm"
                echo "https://1cfresh.com/downloads/platform/1C_Enterprise83-thin-client-nls-${version}.x86_64.rpm"
        done

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
            dpkg-scanpackages --multiversion . /dev/null > Packages
            rm Packages.gz
            gzip -9 Packages
            cd "$3"
            ;;
        "rpm")
            createrepo --database "$2"
            ;;
        *)
            echo "ERR: Wrong extension. Exit." && exit
            ;;
    esac
}
