// swift-tools-version:5.3
import PackageDescription

let isLocalTestMode = false

var deps: [Package.Dependency] = [
    .package(url: "https://github.com/binarybirds/feather-core", from: "1.0.0-beta"),
    .package(url: "https://github.com/malcommac/UAParserSwift", from: "1.2.1"),
    .package(name: "ALanguageParser", url: "https://github.com/matsoftware/accept-language-parser", from: "1.0.0"),
    .package(url: "https://github.com/vapor/sql-kit.git", from: "3.0.0"),
]

var targets: [Target] = [
    .target(name: "AnalyticsModule", dependencies: [
        .product(name: "FeatherCore", package: "feather-core"),
        .product(name: "UAParserSwift", package: "UAParserSwift"),
        .product(name: "ALanguageParser", package: "ALanguageParser"),
        .product(name: "SQLKit", package: "sql-kit"),
    ],
    resources: [
        .copy("Bundle"),
    ]),
]

// @NOTE: https://bugs.swift.org/browse/SR-8658
if isLocalTestMode {
    deps.append(contentsOf: [
        /// drivers
        .package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.0.0"),
        .package(url: "https://github.com/binarybirds/liquid-local-driver", from: "1.2.0"),
        /// core modules
        .package(url: "https://github.com/feathercms/common-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/system-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/user-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/api-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/admin-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/frontend-module", from: "1.0.0-beta"),
    ])
    targets.append(contentsOf: [
        .target(name: "Feather", dependencies: [
            /// drivers
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "LiquidLocalDriver", package: "liquid-local-driver"),
            /// core modules
            .product(name: "CommonModule", package: "common-module"),
            .product(name: "SystemModule", package: "system-module"),
            .product(name: "UserModule", package: "user-module"),
            .product(name: "ApiModule", package: "api-module"),
            .product(name: "AdminModule", package: "admin-module"),
            .product(name: "FrontendModule", package: "frontend-module"),

            .target(name: "AnalyticsModule"),
        ]),
        .testTarget(name: "AnalyticsModuleTests", dependencies: [
            .target(name: "AnalyticsModule"),
        ])
    ])
}

let package = Package(
    name: "analytics-module",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "AnalyticsModule", targets: ["AnalyticsModule"]),
    ],
    dependencies: deps,
    targets: targets
)
