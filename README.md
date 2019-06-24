# Partial

[![Build Status](https://api.travis-ci.com/JosephDuffy/Partial.svg)](https://travis-ci.com/JosephDuffy/Partial)
[![Documentation](https://josephduffy.github.io/Partial/badge.svg)](https://josephduffy.github.io/Partial/)
![Compatible with macOS, iOS, watchOS, tvOS, and Linux](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-4BC51D.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/Partial)
[![MIT License](https://img.shields.io/badge/License-MIT-4BC51D.svg?style=flat)](./LICENSE)

Partial is a type-safe wrapper that makes a type's properties optional, allowing for the type to be constructed with multiple pieces of code contributing values.

⚠️️ The current version of Partial is less than 1.0; the API may change and there may be bugs. Where possible types will be deprecated to aid with upgrades, although this cannot be guaranteed ️️⚠️

# Installation

## SwiftPM

To install via SwiftPM add the package to the dependencies section and as the dependency of a target:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/JosephDuffy/Partial.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "MyApp", dependencies: ["Partial"]),
    ],
    ...
)
```

## Carthage

To install via Carthage add to following to your `Cartfile`:

```
github "JosephDuffy/Partial"
```

Run `carthage update Partial` to build the framework and then drag the built framework file in to your Xcode project. Partial provides pre-compiled binaries, [which can cause some issues with symbols](https://github.com/Carthage/Carthage#dwarfs-symbol-problem). Use the `--no-use-binaries` flag if this is an issue.

Remember to [add Partial to your Carthage build phase](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos):

```
$(SRCROOT)/Carthage/Build/iOS/Partial.framework
```

and

```
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/Partial.framework
```

## CocoaPods

To install via [CocoaPods](https://cocoapods.org) add the following line to your Podfile:

```ruby
pod 'Partial'
```

and then run `pod install`.

# Usage

Partial has a `KeyPath`-based API so is fully type-safe. Reading and writing of values is possible via subscripting, although functions are also provided.

```swift
var partialSize = Partial<CGSize>()
// Properties can be set via a function or subscript
partialSize.set(value: 6016, for: \.width)
partialSize[\.height] = 3384
// And unwrapped with a convenience function
let size = try partialSize.unwrappedValue() // A CGSize with width 6016, height 3384
// Properties can be retrieved via a function call
partialSize.value(for: \.width) // Optional(6016)
try partialSize.value(for: \.width) // 6016
// Properties can be removed via a function for the subscript
partialSize.removeValue(for: \.width)
partialSize[\.width] = nil
```

## Swift 5.1 Features

⚠️️ Swift 5.1 is currently in beta, so these features may break and Partial may not work with future versions of the beta ⚠️

`KeyPath`-based dynamic member lookup is supported in Partial, allowing for properties to be read and set directly on the `Partial` or `PartialBuilder` instance. For example, the main example in Swift 5.1 would be:

```swift
var partialSize = Partial<CGSize>()
partialSize.width = 6016
partialSize.height = 3384
let size = try! partialSize.unwrappedValue() // A CGSize with width 6016, height 3384
```

## Setting values

Values can be set via a subscript, or via the `set(value:for:)` function:

```swift

```

## Building an instance with multiple pieces of code contributing values

Since `Partial` is a value type it is not suitable for being passed between multiple pieces of code. To allow for a single instance of a type to be constructed the `PartialBuilder` class is provided. `PartialBuilder` also provides the ability to be notified when properties are updated.

```swift
let sizeBuilder = PartialBuilder<CGSize>()
sizeBuilder.addUpdateListener { (partial: Partial<CGSize>) in
    print("A value was set")
}
sizeBuilder.addUpdateListener(for: .width) { newWidth in
    print("width has been updated to \(newWidth)")
}

func setWidth(on partial: PartialBuilder<CGSize>) {
    partial[\.width] = 6016
}

func setHeight(on partial: PartialBuilder<CGSize>) {
    partial[\.height] = 3384
}

// Notifies both update listeners
setWidth(on: sizeBuilder)

// Notifies first update listener
setHeight(on: sizeBuilder)

let size = try! sizeBuilder.unwrappedValue() // A CGSize with width 6016, height 3384
```

## Adding support to your own types

Adopting the `PartialConvertible` protocol makes it easy to unwrap a partial value. The protocol has a single requirement:

```swift
public protocol PartialConvertible {
    init(partial: Partial<Self>) throws
}
```

For example, to add `PartialConvertible` conformance to a `CGSize` requires a single function with only a few lines of code:

```swift
extension CGSize: PartialConvertible {
    public init(partial: Partial<Self>) throws {
        let width = try partial.value(for: \.width)
        let height = try partial.value(for: \.height)
        self.init(width: width, height: height)
    }
}
```

As a convenience it's then possible to unwrap partial values that wrap a type that conforms to `PartialConvertible`:

```swift
let sizeBuilder = PartialBuilder<CGSize>()
// ...
let size = try! sizeBuilder.unwrappedValue()
```

# License

The project is released under the MIT license. View the [LICENSE](./LICENSE) file for the full license.