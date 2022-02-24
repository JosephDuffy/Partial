#!/bin/sh

export DEVELOPER_DIR=/Applications/Xcode_13.3-beta.3.app/

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <directory> [base-path]" >&2
     exit 1
fi

if [ "$#" -eq 2 ]; then
    BASE_PATH="$2"
else
    BASE_PATH="/"
fi

swift package \
    --allow-writing-to-directory "$1" \
    generate-documentation \
    --target Partial \
    --disable-indexing \
    --output-path "$1" \
    --transform-for-static-hosting \
    --hosting-base-path "$BASE_PATH"
