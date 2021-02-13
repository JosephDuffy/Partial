#!/bin/sh

KeyPathCodingKeyCollectionBuilder_FILE="Sources/Partial/Codable/KeyPathCodingKeyCollectionBuilder.swift"
PartialCodableTests_FILE="Tests/PartialTests/Tests/PartialCodableTests.swift"

gyb --line-directive '' -o "$KeyPathCodingKeyCollectionBuilder_FILE" "$KeyPathCodingKeyCollectionBuilder_FILE.gyb"
gyb --line-directive '' -o "$PartialCodableTests_FILE" "$PartialCodableTests_FILE.gyb"
