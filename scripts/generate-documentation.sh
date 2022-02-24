#!/bin/sh

/Library/Developer/Toolchains/swift-5.6-DEVELOPMENT-SNAPSHOT-2022-01-11-a.xctoolchain/usr/bin/swift package \
    --allow-writing-to-directory "$1" \
    generate-documentation \
    --target Partial \
    --disable-indexing \
    --output-path "$1" \
    --transform-for-static-hosting \
    --hosting-base-path Partial
