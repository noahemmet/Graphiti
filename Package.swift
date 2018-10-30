// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Graphiti",
    
    products: [
        .library(name: "Graphiti", targets: ["Graphiti"]),
    ],

    dependencies: [
    .package(url: "https://github.com/noahemmet/GraphQL.git", .upToNextMajor(from: "0.6.0")),
    ],

    targets: [
        .target(name: "Graphiti", dependencies: ["GraphQL"]),
        
        .testTarget(name: "GraphitiTests", dependencies: ["Graphiti"]),
    ]
)
