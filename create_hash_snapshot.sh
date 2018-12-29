#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 hash_store"
    exit 1
fi

dirs=("bin" "etc" "home" "media" "opt" "root" "sbin" "tmp" "usr" "var")

hash_store="$1"
touch $hash_store

for d in ${dirs[@]}; do

    while read fname; do

        if [ -f "$fname" ]; then
            cksum "$fname" >> "$hash_store"
        fi
    
    done < <(find "$d" -type f)

done

echo "Done creating $hash_store"

exit 0
