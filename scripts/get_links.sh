#!/bin/bash

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
