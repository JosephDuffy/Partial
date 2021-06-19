// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "DangerChecks",
    platforms: [
        .macOS(.v10_12),
    ],
    products: [
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]),
    ],
    dependencies: [
        .package(name: "danger-swift", url: "https://github.com/danger/swift.git", from: "3.0.0"),
        .package(url: "https://github.com/JosephDuffy/SwiftChecksDangerPlugin.git", from: "0.2.0"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.32.0"),
    ],
    targets: [
        .target(
            name: "DangerDependencies",
            dependencies: [
                .product(name: "Danger", package: "danger-swift"),
                .product(name: "swiftlint", package: "SwiftLint"),
                "SwiftChecksDangerPlugin",
            ],
            path: "DangerDependencies"
        ),
    ]
)
