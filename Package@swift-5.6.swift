// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "Partial",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v2),
    ],
    products: [
        .library(name: "Partial", targets: ["Partial"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.1"),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", branch: "main"),
    ],
    targets: [
        .target(name: "Partial"),
        .testTarget(name: "PartialTests", dependencies: ["Partial", "Quick", "Nimble"]),
    ],
    swiftLanguageVersions: [.v5]
)
