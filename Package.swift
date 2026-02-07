// swift-tools-version: 5.9
import PackageDescription
import Foundation

let packageDir = URL(fileURLWithPath: #filePath).deletingLastPathComponent().path

// MARK: Targets

let cRaylib = Target.target(
    name: "CRaylib",
    path: "Sources/CRaylib",
    publicHeadersPath: "include",
    cSettings: [
        .headerSearchPath("include")
    ],
    linkerSettings: [
        .unsafeFlags(["-L", "\(packageDir)/Sources/CRaylib", "-lraylib"]),
        .linkedLibrary("EGL"),
        .linkedLibrary("GLESv2"),
        .linkedFramework("Cocoa"),
        .linkedFramework("IOKit"),
        .linkedFramework("CoreVideo"),
        .linkedFramework("CoreAudio"),
        .linkedFramework("AudioToolbox")
    ]
)

let cImGui = Target.target(
    name: "CImGui",
    path: "Sources/CImGui",
    publicHeadersPath: "include",
    cSettings: [
        .headerSearchPath("include"),
        .define("CIMGUI_DEFINE_ENUMS_AND_STRUCTS"),
        .define("CIMGUI_USE_OPENGL3"),
        .define("IMGUI_IMPL_OPENGL_ES2")
    ],
    linkerSettings: [
        .unsafeFlags(["-L", "\(packageDir)/Sources/CImGui", "-lcimgui"])
    ]
)

let swiftSketchCore = Target.target(
    name: "SwiftSketchCore",
    dependencies: ["CRaylib", "CImGui"],
    path: "Sources/SwiftSketchCore",
    linkerSettings: [
        .unsafeFlags(["\(packageDir)/Sources/CImGui/libcimgui.a"])
    ]
)

let app = Target.executableTarget(
    name: "App",
    dependencies: ["SwiftSketchCore"],
    path: "Sources/App",
    linkerSettings: [
        .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@executable_path"])
    ]
)

let swiftUIApp = Target.executableTarget(
    name: "SwiftUIApp",
    dependencies: ["SwiftSketchCore"],
    path: "Sources/SwiftUIApp"
)

let package = Package(
    name: "SwiftC",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "CRaylib",
            type: .static,
            targets: ["CRaylib"]
        ),
        .library(
            name: "CImGui",
            type: .static,
            targets: ["CImGui"]
        ),
        .library(
            name: "SwiftSketchCore",
            type: .static,
            targets: ["SwiftSketchCore"]
        ),
        .executable(
            name: "App",
            targets: ["App"]
        ),
        .executable(
            name: "SwiftUIApp",
            targets: ["SwiftUIApp"]
        )
    ],
    targets: [
        cRaylib,
        cImGui,
        swiftSketchCore,
        app,
        swiftUIApp
    ]
)

package.targets
    .filter { $0.type != .binary }
    .forEach {
        $0.swiftSettings = [
            .unsafeFlags([
                "-Xfrontend",
                "-warn-long-function-bodies=100",
                "-Xfrontend",
                "-warn-long-expression-type-checking=100"
            ])
        ]
    }
