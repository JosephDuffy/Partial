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

# Documentation

Partial is fully documented, with [documentation available online](https://josephduffy.github.io/Partial/). The online documentation is generated from the source code with every release, so it is up-to-date with the latest release, but may be different to the code in `master`.

# Usage

Partial has a `KeyPath`-based API so is fully type-safe. Reading and writing of values is possible via subscripting, although functions are also provided.

```swift
var partialSize = Partial<CGSize>()
// Key paths can be set via a function or subscript
partialSize.setValue(6016, for: \.width)
partialSize[\.height] = 3384
// And unwrapped with a convenience function
let size = try partialSize.unwrappedValue() // A `CGSize(width: 6016, height: 3384)`
// Key paths can be retrieved via a throwing function or a subscript
try partialSize.value(for: \.width) // `6016`
partialSize[\.width] // `Optional<CGFloat>(6016)`
// Key paths can be removed via a function or the subscript
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
let size = try! partialSize.unwrappedValue() // A `CGSize(width: 6016, height: 3384)`
partialSize.width // `Optional<CGFloat>(6016)`
partialSize.height = nil // Removes value for `height`
```

## Setting values

Values can be set via a subscript, or via the `setValue(_:for:)` function:

```swift
var partialSize = Partial<CGSize>()
partialSize.setValue(6016, for: \.width)
partialSize[\.height] = 3384
```

Optional values can be set to `nil` using the the `setValue(_:for:)` function or the subscript:

```swift
struct Foo {
    let bar: String?
}
var partial = Partial<Foo>()
partial.setValue(nil, for: \.bar)
// Setting the value to `nil` would remove the value
// This is equivalent to setting the value to `String??.some(nil)`
partial[\.bar] = String?.none
```

## Retrieving values

Values can be retrieved via the `value(for:)` function or the subscript:

```swift
var partialSize = Partial<CGSize>()
try partialSize.value(for: \.width) // Throws `Partial.Error.keyPathNotSet(\.width)`
partialSize[\.width] // `Optional<CGFloat>.none`
partialSize[\.width] = 6016
try partialSize.value(for: \.width) // `6016`
partialSize[\.width] // `Optional<CGFloat>(6016)`
```

`Optional` values returned via the subscript will be doubly wrapped:

```swift
struct Foo {
    let bar: String?
}
var partial = Partial<Foo>()

switch partial[\.bar] {
case .some(let value):
    switch value {
    case .some(let unwrapped):
        // Value has been set to `unwrapped`
        break
    case .none:
        // Value has been set to `nil`
        break
    }
case .none:
    // Value has not been set
    break
}
```

## Building an instance with multiple pieces of code contributing values

Since `Partial` is a value type it is not suitable for being passed between multiple pieces of code. To allow for a single instance of a type to be constructed the `PartialBuilder` class is provided. `PartialBuilder` also provides the ability to subscribed to updates.

```swift
let sizeBuilder = PartialBuilder<CGSize>()
let allChangesSubscription = sizeBuilder.subscribeToAllChanges { (keyPath: PartialKeyPath<CGSize>, builder: PartialBuilder<CGSize>) in
    print("\(keyPath) was updated")
}
var widthSubscription = sizeBuilder.subscribeForChanges(to: \.width) { update in
    print("width has been updated from \(update.oldValue) to \(update.newValue)")
}

// Notifies both subscribers
partial[\.width] = 6016

// Notifies the all changes subscriber
partial[\.height] = 3384

// Subscriptions can be manually cancelled
allChangesSubscription.cancel()
// Notifies the width subscriber
partial[\.width] = 6016

// Subscriptions will be cancelled when deallocated
widthSubscription = nil
// Does not notify any subscribers
partial[\.width] = 6016
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

It is also possible to set a key path to a partial value. If the unwrapping fails the key path will not be updated and the error will be thrown:

```swift
struct Foo {
    let size: CGSize
}
var partialFoo = Partial<Foo>()
var partialSize = Partial<CGSize>()
partialSize[\.width] = 6016
try partialFoo.setValue(partialSize, for: \.size) // Throws `Partial<CGSize>.Error.keyPathNotSet(\.height)`
partialSize[\.height] = 3384
try partialFoo.setValue(partialSize, for: \.size) // Sets `size` to `CGSize(width: 6016, height: 3384)`
```

# Tests and CI

Partial has a full test suite, which is run on [Travis CI](https://travis-ci.com/JosephDuffy/Partial) as part of pull requests. All tests must pass for a pull request to be merged.

Code coverage is collected and reported to to [Codecov](https://codecov.io/gh/JosephDuffy/Partial). 100% coverage is not possible; some lines of code should never be hit but are required for type-safety, and Swift does not track `deinit` functions as part of coverage. These limitations will be considered when approving a pull request that lowers the overall code coverage.

# License

The project is released under the MIT license. View the [LICENSE](./LICENSE) file for the full license.