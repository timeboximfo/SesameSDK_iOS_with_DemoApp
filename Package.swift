// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "SesameSDK",
  platforms: [
    .iOS(.v12), .macOS(.v10_15), .watchOS(.v7)
  ],
  products: [
    .library(name: "SesameSDK", targets: ["SesameSDK"]),
  ],
  // ★ AWS SDK を依存に追加
  dependencies: [
    .package(url: "https://github.com/aws-amplify/aws-sdk-ios-spm",
             .upToNextMajor(from: "2.41.0"))
  ],
  targets: [
    .target(
      name: "SesameSDK",
      dependencies: [
        "AESc",
        .product(name: "AWSCore", package: "aws-sdk-ios-spm"),
        .product(name: "AWSCognitoIdentityProvider", package: "aws-sdk-ios-spm"),
        .product(name: "AWSIoT", package: "aws-sdk-ios-spm")
      ],
      resources: [
        .process("DB/CHDeviceModel.xcdatamodeld")
      ]
    ),
    .target(name: "AESc")
  ]
)
