// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Graphiti",
    
    products: [
        .library(name: "Graphiti", targets: ["Graphiti"]),
    ],

    dependencies: [
    .package(url: "https://github.com/noahemmet/GraphQL.git", .branch("swift-42")),
    ],

    targets: [
        .target(name: "Graphiti", dependencies: ["GraphQL"]),
        
        .testTarget(name: "GraphitiTests", dependencies: ["Graphiti"]),
    ]
)
