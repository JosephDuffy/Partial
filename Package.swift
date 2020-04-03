// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Partial",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v2),
    ],
    products: [
        .library(name: "Partial", targets: ["Partial"]),
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]),
    ],
    dependencies: [
        .package(name: "danger-swift", url: "https://github.com/danger/swift.git", from: "3.0.0"),
        .package(url: "https://github.com/JosephDuffy/SwiftChecksDangerPlugin.git", from: "0.2.0"),
        .package(url: "https://github.com/Quick/Quick.git", from: "2.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.32.0"),
        .package(url: "https://github.com/f-meloni/Rocket", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Partial"),
        .testTarget(name: "PartialTests", dependencies: ["Partial", "Quick", "Nimble"]),
        .target(
            name: "DangerDependencies",
            dependencies: [
                .product(name: "Danger", package: "danger-swift"),
                .product(name: "swiftlint", package: "SwiftLint"),
                "SwiftChecksDangerPlugin",
            ],
            path: "DangerDependencies"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
