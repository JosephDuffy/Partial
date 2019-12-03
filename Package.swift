// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Partial",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v2),
    ],
    products: [
        .library(name: "Partial", targets: ["Partial"]),
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]), // dev
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "2.0.0"), // dev
        .package(url: "https://github.com/JosephDuffy/SwiftChecksDangerPlugin.git", from: "0.1.0"), // dev
        .package(url: "https://github.com/Quick/Quick.git", from: "2.0.0"), // dev
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0"), // dev
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.32.0"), // dev
        .package(url: "https://github.com/f-meloni/Rocket", from: "0.1.0"), // dev
    ],
    targets: [
        .target(name: "Partial"),
        .testTarget(name: "PartialTests", dependencies: ["Partial", "Quick", "Nimble"]), // dev
        .target(name: "DangerDependencies", dependencies: ["Danger", "swiftlint", "danger-swift", "SwiftChecksDangerPlugin"], path: "DangerDependencies"), // dev
    ],
    swiftLanguageVersions: [.v5]
)
