// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DogBreedsComponent",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "DogBreedsComponent",
            targets: ["DogBreedsComponent"]
        ),
    ],
    dependencies: [
        .package(
            name: "swift-composable-architecture",
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            .exact("0.17.0")
        ),
        .package(
            name: "Kingfisher",
            url: "https://github.com/onevcat/Kingfisher",
            .exact("6.2.1"))
    ],
    targets: [
        .target(
            name: "DogBreedsComponent",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ]
        ),
        .testTarget(
            name: "DogBreedsComponentTests",
            dependencies: [
                "DogBreedsComponent",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
    ]
)
