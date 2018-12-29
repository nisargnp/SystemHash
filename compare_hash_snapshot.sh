#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 hash_store out_file_name"
    exit 1
fi

dirs=("bin" "etc" "home" "media" "opt" "root" "sbin" "tmp" "usr" "var")

hash_store="$1"
out_file_name="$2"

# create a temp hash_store
cp -f "$hash_store" "${hash_store}.tmp"

for d in ${dirs[@]}; do

    while read fname; do

        if [ -f "$fname" ]; then
            cksum "$fname" >> "${hash_store}.tmp"
        fi
    
    done < <(find "$d" -type f) #-perm -g+r

done

# sort the hash_store
sort -o "${hash_store}.tmp" < "${hash_store}.tmp"

# find the unique and different entires
uniq -u < "${hash_store}.tmp" > "${out_file_name}.unique"
uniq -d < "${hash_store}.tmp" > "${out_file_name}.duplicate"

# get the number of unique and different entries
echo "$(wc -l < "${out_file_name}.unique") $(wc -l < "${out_file_name}.duplicate")" > "${out_file_name}.stats"

# remove the temp file
rm "${hash_store}.tmp"

cat "${out_file_name}.stats" "${out_file_name}" > "${out_file_name}.tmp"
cat "${out_file_name}.tmp" > "$out_file_name"
rm "${out_file_name}.tmp"

exit 0
