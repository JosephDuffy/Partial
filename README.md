# Partial

[![Build Status](https://github.com/JosephDuffy/Partial/workflows/Tests/badge.svg)](https://github.com/JosephDuffy/Partial/actions?query=workflow%3ATests)
[![Documentation](https://josephduffy.github.io/Partial/badge.svg)](https://josephduffy.github.io/Partial/)
![Compatible with macOS, iOS, watchOS, tvOS, and Linux](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-4BC51D.svg)
![Compatible with Swift 5.0+](https://img.shields.io/badge/swift-5.0%2B-4BC51D.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/Partial)
[![MIT License](https://img.shields.io/badge/License-MIT-4BC51D.svg?style=flat)](./LICENSE)

Partial is a type-safe wrapper that mirrors the properties of the wrapped type but makes each property optional.

```swift
var partialSize = Partial<CGSize>()

partialSize.width = 6016
partialSize.height = 3384
try CGSize(partial: partialSize) // `CGSize(width: 6016, height: 3384)`

partialSize.height = nil
try CGSize(partial: partialSize) // Throws `Partial<CGSize>.Error<CGFloat>.keyPathNotSet(\.height)`
```

# Documentation

Partial is fully documented, with [code-level documentation available online](https://josephduffy.github.io/Partial/). The online documentation is generated from the source code with every release, so it is up-to-date with the latest release, but may be different to the code in `master`.

## Usage overview

Partial has a `KeyPath`-based API, allowing it to be fully type-safe. Setting, retrieving, and removing key paths is possible via dynamic member lookup or functions.

```swift
var partialSize = Partial<CGSize>()

// Set key paths
partialSize.width = 6016
partialSize.setValue(3384, for: \.height)

// Retrieve key paths
partialSize.width // `Optional<CGFloat>(6016)`
try partialSize.value(for: \.height) // `3384`

// Remove key paths
partialSize.width = nil
partialSize.removeValue(for: \.width)
```

## Key path considerations

Key paths in Swift are very powerful, but by being so powerful they create a couple of caveats with the usage of partial.

In general **I highly recommend you do not use key paths to a property of a property**. The reason for this is 2 fold:

- It creates ambiguity when unwrapping a partial
- Dynamic member lookup does not support key paths to a property of a property

```swift
struct SizeWrapper: PartialConvertible {
    let size: CGSize

    init<PartialType: PartialProtocol>(partial: PartialType) throws where PartialType.Wrapped == SizeWrapper {
        // Should unwrap `size` directly...
        size = try partial.value(for: \.size)
        // ... or unwrap each property of `size`?
        let width = try partial.value(for: \.size.width)
        let height = try partial.value(for: \.size.height)
        size = CGSize(width: width, height: height)
    }
}

var sizeWrapperPartial = Partial<SizeWrapper>()
sizeWrapperPartial.size.width = 6016 // This is not possible
```

## Building complex types

Since `Partial` is a value type it is not suitable for being passed between multiple pieces of code. To allow for a single instance of a type to be constructed the `PartialBuilder` class is provided, which also provides the ability to subscribe to updates.

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

When building a more complex type I recommend using a builder per-property and using the builders to set the key paths on the root builder:

```swift
struct Root {
    let size1: CGSize
    let size2: CGSize
}

let rootBuilder = PartialBuilder<Root>()
let size1Builder = rootBuilder.builder(for: \.size1)
let size2Builder = rootBuilder.builder(for: \.size2)

size1Builder.setValue(1, for: \.width)
size1Builder.setValue(2, for: \.height)

// These will evaluate to `true`
try? size1Builder.unwrapped() == CGSize(width: 1, height: 2)
try? rootBuilder.value(for: \.size1) == CGSize(width: 1, height: 2)
try? rootBuilder.value(for: \.size2) == nil
```

The per-property builders are synchronized using a `Subscription`. You can cancel the subscription by using `PropertyBuilder.detach()`, like so:

```swift
size2Builder.detach()
size2Builder.setValue(3, for: \.width)
size2Builder.setValue(4, for: \.height)

// These will evaluate to `true`
try? size2Builder.unwrapped() == CGSize(width: 3, height: 4)
try? rootBuilder.value(for: \.size2) == nil
```

## Dealing with `Optional`s

Partials mirror the properties of the wrapping type exactly, meaning that optional properties will still be optional. This isn't much of a problem with the `value(for:)` and `setValue(_:for:)` functions, but can be a bit more cumbersome when using dynamic member lookup because the optional will be wrapped in another optional.

These examples will use a type that has an optional property:

```swift
struct Foo {
    let bar: String?
}
var fooPartial = Partial<Foo>()
```

Setting and retrieving optional values with the `setValue(_:for:)` and `value(for:)` functions does not require anything special:

```swift
try fooPartial.value(for: \.bar) // Throws `Partial<Foo>.Error<String?>.keyPathNotSet(\.bar)`
fooPartial.setValue(nil, for: \.bar)
try fooPartial.value(for: \.bar) // Returns `String?.none`
```

However using dynamic member lookup requires a little more consideration:

```swift
fooPartial.bar = String?.none // Sets the value to `nil`
fooPartial.bar = nil // Removes the value. Equivalent to setting to `String??.none`
```

When retrieving values it can be necessary to unwrap the value twice:

```swift
if let setValue = fooPartial.bar {
    if let unwrapped = setValue {
        print("`bar` has been set to", unwrapped)
    } else {
        print("`bar` has been set to `nil`")
    }
} else {
    print("`bar` has not been set")
}
```

## Adding support to your own types

Adopting the `PartialConvertible` protocol declares that a type can be initialised with a partial:

```swift
protocol PartialConvertible {
    init<PartialType: PartialProtocol>(partial: PartialType) throws where PartialType.Wrapped == Self
}
```

The `value(for:)` function will throw an error if the key path has not been set, which can be useful when adding conformance. For example, to add `PartialConvertible` conformance to `CGSize` you could use `value(for:)` to retrieve the `width` and `height` values:

```swift
extension CGSize: PartialConvertible {
    public init<PartialType: PartialProtocol>(partial: PartialType) throws where PartialType.Wrapped == CGSize {
        let width = try partial.value(for: \.width)
        let height = try partial.value(for: \.height)
        self.init(width: width, height: height)
    }
}
```

As a convenience it's then possible to unwrap partials that wrap a type that conforms to `PartialConvertible`:

```swift
let sizeBuilder = PartialBuilder<CGSize>()
// ...
let size = try! sizeBuilder.unwrapped()
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

## Using the Property Wrapper

`PartiallyBuilt` is a property wrapper that can be applied to any `PartialConvertible` property. The property wrapper's `projectedValue` is a `PartialBuilder`, allowing for the following usage:

```swift
struct Foo {
    @PartiallyBuilt<CGSize>
    var size: CGSize?
}

var foo = Foo()
foo.size // nil
foo.$size.width = 1024
foo.$size.height = 720
foo.size // CGSize(width: 1024, height: 720)
```

# Tests and CI

Partial has a full test suite, which is run on [GitHub Actions](https://github.com/JosephDuffy/Partial/actions?query=workflow%3ATests) as part of pull requests. All tests must pass for a pull request to be merged.

Code coverage is collected and reported to to [Codecov](https://codecov.io/gh/JosephDuffy/Partial). 100% coverage is not possible; some lines of code should never be hit but are required for type-safety, and Swift does not track `deinit` functions as part of coverage. These limitations will be considered when reviewing a pull request that lowers the overall code coverage.

# Installation

## SwiftPM

To install via [SwiftPM](https://github.com/apple/swift-package-manager) add the package to the dependencies section and as the dependency of a target:

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

To install via [Carthage](https://github.com/Carthage/Carthage) add to following to your `Cartfile`:

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

To install via [CocoaPods](https://cocoapods.org) add the following to your Podfile:

```ruby
pod 'Partial'
```

and then run `pod install`.

# License

The project is released under the MIT license. View the [LICENSE](./LICENSE) file for the full license.
