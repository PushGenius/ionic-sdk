// swift-tools-version: 5.9
import PackageDescription

// The Capacitor CLI derives this name from the npm package name (@pushgenius/ionic -> PushgeniusIonic),
// so the package, product, and podspec must all use it.

let package = Package(
  name: "PushgeniusIonic",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "PushgeniusIonic", targets: ["PushgeniusIonic"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", "6.0.0"..<"9.0.0"),
  ],
  targets: [
    .target(
      name: "PushgeniusIonic",
      dependencies: [
        .product(name: "Capacitor", package: "capacitor-swift-pm"),
        .product(name: "Cordova", package: "capacitor-swift-pm"),
      ],
      path: "ios/Sources/PushGeniusIonic",
      resources: [.copy("Core/PrivacyInfo.xcprivacy")]
    ),
  ]
)
