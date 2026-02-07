import Foundation
@_exported import CRaylib
// import SwiftSketchCore -- Removed circular dependency

public enum App {
    static public private(set) var fps = 120
    static public private(set) var screenWidth = 1280
    static public private(set) var screenHeight = 720

    static var backgroundColor: Color?

    public static let scrWidth = 1280
    public static let scrHeight = 720

    private static var shouldRender = true
    private static var defaultTitle = "SwiftSketch"
    private static var defaultShowFPS = true
    private static var imguiEnabled = false
#if !SS_MINIMAL && !SS_NO_IMGUI
    private static var imguiTheme: ImGuiTheme = .dark
    private static var imguiGlslVersion = "#version 100"
#endif

    public static var raylibVersion: String {
        return "5.6-dev"
    }

    public static func initWindow(
        w: Int = App.scrWidth,
        h: Int = App.scrHeight,
        title: String? = nil,
        targetFPS: Int = 120,
        bgColor: Color = .white,
        configFlags: UInt32? = nil
    ) {
        let resolvedTitle = title ?? defaultTitle
        let defaultFlags = UInt32(FLAG_WINDOW_HIGHDPI.rawValue) | UInt32(FLAG_MSAA_4X_HINT.rawValue)
        let resolvedFlags = configFlags ?? defaultFlags
        SetConfigFlags(resolvedFlags)
        InitWindow(Int32(w), Int32(h), resolvedTitle)
        App.backgroundColor = bgColor
        fps = targetFPS
        screenWidth = w
        screenHeight = h
        SetTargetFPS(Int32(targetFPS))
    }

    public static func fps(_ value: Bool) {
        defaultShowFPS = value
    }
    
    public static func enableImGui(
        theme: ImGuiTheme = .dark,
        glslVersion: String = "#version 100"
    ) {
#if !SS_MINIMAL && !SS_NO_IMGUI
        imguiEnabled = true
        imguiTheme = theme
        imguiGlslVersion = glslVersion
        if IsWindowReady() {
            ImGuiCore.initialize(theme: imguiTheme, glslVersion: imguiGlslVersion)
        }
#else
        _ = theme
        _ = glslVersion
#endif
    }

    public final class Renderer {
        private let showFPS: Bool
        private let update: () -> Void
        private let draw: () -> Void
        private let unload: () -> Void
        private let autoInitWindow: Bool
        private let closeWindowOnShutdown: Bool
        private var initialized = false
        private var shutdownDone = false

        fileprivate init(
            showFPS: Bool,
            autoInitWindow: Bool,
            closeWindowOnShutdown: Bool,
            update: @escaping () -> Void,
            draw: @escaping () -> Void,
            unload: @escaping () -> Void
        ) {
            self.showFPS = showFPS
            self.autoInitWindow = autoInitWindow
            self.closeWindowOnShutdown = closeWindowOnShutdown
            self.update = update
            self.draw = draw
            self.unload = unload
        }

        private func ensureInitialized() -> Bool {
            if initialized {
                return true
            }
            if !IsWindowReady() {
                guard autoInitWindow else { return false }
                App.initWindow()
            }
            Key.setExitKey(.escape)
#if !SS_MINIMAL && !SS_NO_IMGUI
            if App.imguiEnabled && !ImGuiCore.isInitialized {
                ImGuiCore.initialize(theme: App.imguiTheme, glslVersion: App.imguiGlslVersion)
            }
#endif
            initialized = true
            return true
        }

        public func step() -> Bool {
            guard ensureInitialized() else { return false }
            if WindowShouldClose() {
                shutdown()
                return false
            }
            update()
            Render.beginDrawing()
            if let color = App.backgroundColor {
                Render.clearBackground(color)
            }
#if !SS_MINIMAL && !SS_NO_IMGUI
            if App.imguiEnabled {
                ImGuiCore.newFrame()
            }
#endif
            draw()
            if showFPS {
                Render.drawFPS(x: 10, y: 10)
            }
#if !SS_MINIMAL && !SS_NO_IMGUI
            if App.imguiEnabled {
                ImGuiCore.render()
            }
#endif
            Render.endDrawing()
            return true
        }

        public func run() {
            while step() {}
        }

        public func shutdown() {
            if shutdownDone {
                return
            }
            unload()
#if !SS_MINIMAL && !SS_NO_IMGUI
            if App.imguiEnabled {
                ImGuiCore.shutdown()
            }
#endif
            if closeWindowOnShutdown && IsWindowReady() {
                CloseWindow()
            }
            shutdownDone = true
        }
    }

    public static func makeRenderer(
        showFPS: Bool? = nil,
        autoInitWindow: Bool = true,
        closeWindowOnShutdown: Bool = true,
        update: @escaping () -> Void = {},
        draw: @escaping () -> Void,
        unload: @escaping () -> Void = {}
    ) -> Renderer {
        let resolvedShowFPS = showFPS ?? defaultShowFPS
        return Renderer(
            showFPS: resolvedShowFPS,
            autoInitWindow: autoInitWindow,
            closeWindowOnShutdown: closeWindowOnShutdown,
            update: update,
            draw: draw,
            unload: unload
        )
    }

    public static func run(sketch: Sketch) {
        sketch.setup()
        let renderer = App.makeRenderer(
            update: { sketch.update() },
            draw: { sketch.draw() }
        )
        renderer.run()
    }
}
