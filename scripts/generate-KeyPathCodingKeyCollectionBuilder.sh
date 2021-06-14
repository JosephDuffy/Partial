#!/bin/sh

KeyPathCodingKeyCollectionBuilder_FILE="Sources/Partial/Codable/KeyPathCodingKeyCollectionBuilder.swift"
PartialCodableTests_FILE="Tests/PartialTests/Tests/Partial+CodableTests.swift"
PartialBuilderCodableTests_FILE="Tests/PartialTests/Tests/PartialBuilder+CodableTests.swift"

gyb --line-directive '' -o "$KeyPathCodingKeyCollectionBuilder_FILE" "$KeyPathCodingKeyCollectionBuilder_FILE.gyb"
gyb --line-directive '' -o "$PartialCodableTests_FILE" "$PartialCodableTests_FILE.gyb"
gyb --line-directive '' -o "$PartialBuilderCodableTests_FILE" "$PartialBuilderCodableTests_FILE.gyb"
