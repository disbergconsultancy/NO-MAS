// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NoMas",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "NoMas", targets: ["NoMas"]),
        .executable(name: "NoMasTests", targets: ["NoMasTests"]),
        .library(name: "NoMasCore", targets: ["NoMasCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/sindresorhus/LaunchAtLogin-Modern", from: "1.0.0")
    ],
    targets: [
        // Core library containing testable logic
        .target(
            name: "NoMasCore",
            dependencies: [],
            path: "Sources/NoMasCore"
        ),
        // Main executable
        .executableTarget(
            name: "NoMas",
            dependencies: [
                "NoMasCore",
                .product(name: "LaunchAtLogin", package: "LaunchAtLogin-Modern")
            ],
            path: "Sources/NoMas",
            exclude: ["Resources/Info.plist"]
        ),
        // Test executable
        .executableTarget(
            name: "NoMasTests",
            dependencies: ["NoMasCore"],
            path: "Tests/NoMasTests",
            sources: ["TestRunner.swift"]
        )
    ]
)
