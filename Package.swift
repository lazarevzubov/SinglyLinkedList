// swift-tools-version:6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SinglyLinkedList",
    products: [.library(name: "SinglyLinkedList", targets: ["SinglyLinkedList"])],
    targets: [
        .target(name: "SinglyLinkedList"),
        .testTarget(name: "SinglyLinkedListTests", dependencies: ["SinglyLinkedList"]),
    ]
)
