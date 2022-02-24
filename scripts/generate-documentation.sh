#!/bin/sh

export DEVELOPER_DIR=/Applications/Xcode_13.3-beta.3.app/

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <directory>" >&2
     exit 1
fi

swift package \
    --allow-writing-to-directory "$1" \
    generate-documentation \
    --target Partial \
    --disable-indexing \
    --output-path "$1" \
    --transform-for-static-hosting \
    --hosting-base-path Partial
