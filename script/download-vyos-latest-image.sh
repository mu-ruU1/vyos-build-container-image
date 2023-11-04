#!/bin/bash

set -e

USERNAME="vyos"
REPO="vyos-rolling-nightly-builds"

release_info=$(curl -s "https://api.github.com/repos/$USERNAME/$REPO/releases/latest")

download_url=$(echo "$release_info" | jq -r '.assets[0].browser_download_url')

tag_name=$(echo "$release_info" | jq -r '.tag_name' | rev | cut -c 5- | rev)
echo "tag_name=$tag_name" >> $GITHUB_ENV

curl -L -o vyos-rolling-latest.iso "$download_url"
