#!/bin/bash

if [ $# -ne 1 ]; then
    echo "A single argument specifying the version must be provided"
    exit 1
fi

VERSION=$1
NORMALISED_VERSION=${VERSION#"v"}

if [ "$NORMALISED_VERSION" = "$VERSION" ]; then
    echo "Version should start with a \"v\""
    exit 1
fi

echo "Setting version in Xcode project to $NORMALISED_VERSION"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '$NORMALISED_VERSION'" ./Partial.xcodeproj/Partial_Info.plist
echo "Setting version in Podspec to $NORMALISED_VERSION"
sed -E -i "" "s/(spec\\.version[[:blank:]]*=[[:blank:]]*)\".*\"/\1\"$NORMALISED_VERSION\"/" ./Partial.podspec
