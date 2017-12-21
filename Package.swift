// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Arvostelu",
    products: [
        .library(
            name: "ArvosteluCore",
            targets: ["ArvosteluCore"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ArvosteluCore",
            dependencies: []),
        .testTarget(
            name: "ArvosteluCoreTests",
            dependencies: ["ArvosteluCore"]),
    ]
)
