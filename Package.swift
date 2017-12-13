// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Arvostelu",
    products: [
        .executable(
            name: "Arvostelu",
            targets: ["Arvostelu"]),
        .library(
            name: "ArvosteluCore",
            targets: ["ArvosteluCore"]),
    ],
    dependencies: [
        //
    ],
    targets: [
        .target(
            name: "ArvosteluCore",
            dependencies: []),
        .target(
            name: "Arvostelu",
            dependencies: ["ArvosteluCore"]),
        .testTarget(
            name: "ArvosteluTests",
            dependencies: ["ArvosteluCore"]),
    ]
)
