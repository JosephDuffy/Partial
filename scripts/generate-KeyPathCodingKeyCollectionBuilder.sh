#!/bin/sh

GYB_FILE="Sources/Partial/Codable/KeyPathCodingKeyCollectionBuilder.swift"
gyb --line-directive '' -o "$GYB_FILE" "$GYB_FILE.gyb"
