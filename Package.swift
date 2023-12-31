// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "DangerSwiftTest",
    dependencies: [
      .package(url: "https://github.com/danger/swift.git", from: "2.0.6")
    ],
    targets: [
        // This is just an arbitrary Swift file in our app, that has
        // no dependencies outside of Foundation, the dependencies section
        // ensures that the library for Danger gets build also.
        .target(name: "DangerSwiftTest", dependencies: ["Danger"], path: "./DangerSwiftTest"),
    ]
)