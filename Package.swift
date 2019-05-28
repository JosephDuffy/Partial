// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Partial",
    products: [
        .library(name: "Partial", type: .dynamic, targets: ["Partial"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "1.0.0"), // dev
        .package(url: "https://github.com/Quick/Quick.git", from: "2.0.0"), // dev
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0"), // dev
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.32.0"), // dev
    ],
    targets: [
        .target(name: "Partial", path: "Source"),
        .testTarget(name: "PartialTests", dependencies: ["Partial", "Quick", "Nimble"], path: "Tests"),
    ]
)
