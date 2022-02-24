#!/bin/sh

export DEVELOPER_DIR=/Applications/Xcode_13.3-beta.3.app/
swift package \
    --allow-writing-to-directory "$1" \
    generate-documentation \
    --target Partial \
    --disable-indexing \
    --output-path "$1" \
    --transform-for-static-hosting \
    --hosting-base-path Partial
