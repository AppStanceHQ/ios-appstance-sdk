// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "AppStanceSDK",
    platforms: [
        .iOS(.v13) // Adjust minimum iOS version as needed
    ],
    products: [
        .library(
            name: "AppStanceSDK",
            targets: ["AppStanceSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "AppStanceSDK",
            path: "./AppStanceSDK.xcframework"

        )
    ]
)