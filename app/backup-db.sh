#!/usr/bin/env bash

# load environment variables
# shellcheck source=/dev/null
# shellcheck disable=SC2046
[ ! -f .env ] || export $(xargs <.env)
source stashapp.sh

trap ctrl_c INT
function ctrl_c() {
    exit 1
}

set -e

validate() {
    if [ -z "$STASH_URL" ] || [ -z "$STASH_APIKEY" ]; then
        echo "STASH_URL and STASH_APIKEY must be set"
        exit 1
    fi
}

# trigger backup from GQL
download() {
    download_url=$(stash_gql 'mutation backup { backupDatabase(input: { download: true }) }' | jq -r '.data.backupDatabase')
    # download backup
    filename="$(date +%Y%m%d-%H%M%S).sqlite"
    stash_dump "$filename" "$download_url"
}

validate
mkdir -p backup/db && cd backup/db || exit
download
file_size="$(du -bhL "$filename" | cut -f1)"
echo "Backup complete - $filename with size $file_size"
