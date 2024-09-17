#!/bin/sh

base_url="https://www.indus.epigraphica.de/signlist/small"
username="icit"
password="seal123"

# Function to download a single image
download_image() {
    sign_id=$(printf "S%03d" "$1")
    file_url="$base_url/${sign_id}.jpg"

    # Download the file only if it exists (HTTP status 200)
    if curl --user "$username:$password" --head --silent --fail "$file_url" > /dev/null; then
        echo "Downloading $file_url"
        curl --user "$username:$password" -O "$file_url"
    else
        echo "Skipping $file_url (not found)"
    fi
}

export -f download_image
export base_url username password

# Parallelize the download with xargs and pass the range 0-999
seq 0 999 | xargs -n 1 -P 10 bash -c 'download_image "$@"' _
