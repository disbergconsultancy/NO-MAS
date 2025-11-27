// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "CalSync",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "CalSync", targets: ["CalSync"]),
        .executable(name: "CalSyncTests", targets: ["CalSyncTests"]),
        .library(name: "CalSyncCore", targets: ["CalSyncCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/sindresorhus/LaunchAtLogin-Modern", from: "1.0.0")
    ],
    targets: [
        // Core library containing testable logic
        .target(
            name: "CalSyncCore",
            dependencies: [],
            path: "Sources/CalSyncCore"
        ),
        // Main executable
        .executableTarget(
            name: "CalSync",
            dependencies: [
                "CalSyncCore",
                .product(name: "LaunchAtLogin", package: "LaunchAtLogin-Modern")
            ],
            path: "Sources/CalSync",
            exclude: ["Resources/Info.plist"]
        ),
        // Test executable
        .executableTarget(
            name: "CalSyncTests",
            dependencies: ["CalSyncCore"],
            path: "Tests/CalSyncTests",
            sources: ["TestRunner.swift"]
        )
    ]
)
