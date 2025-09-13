// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SesameSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "SesameSDK", targets: ["SesameSDK"]),
        .library(name: "AESc", targets: ["AESc"])
    ],
    // ★ AWS SDK を安定版で依存追加（2.41.0 以降）
    dependencies: [
        .package(
            url: "https://github.com/aws-amplify/aws-sdk-ios-spm",
            .upToNextMajor(from: "2.41.0")
        )
    ],
    targets: [
        .target(
            name: "AESc",
            path: "Sources/AESc",
            publicHeadersPath: "."
        ),
        .target(
            name: "SesameSDK",
            dependencies: [
                "AESc",
                .product(name: "AWSCore", package: "aws-sdk-ios-spm"),
                // ★ これが不足していた
                .product(name: "AWSCognitoIdentityProvider", package: "aws-sdk-ios-spm"),
                .product(name: "AWSIoT", package: "aws-sdk-ios-spm")
                // ※ AWSAPIGateway は SesameSDK のコードで使っていなければ不要です
            ],
            path: "Sources/SesameSDK",
            resources: [
                .process("DB/CHDeviceModel.xcdatamodeld")
            ]
        )
    ]
)
