// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Arvostelu",
    products: [
        .executable(
            name: "Arvostelu",
            targets: ["Arvostelu"]
        ),
        .library(
            name: "ArvosteluCore",
            targets: ["ArvosteluCore"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Arvostelu",
            dependencies: ["ArvosteluCore"]
        ),
        .target(
            name: "ArvosteluCore",
            dependencies: []),
        .testTarget(
            name: "ArvosteluCoreTests",
            dependencies: ["ArvosteluCore"]),
    ]
)
