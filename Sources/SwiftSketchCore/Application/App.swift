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
        bgColor: Color = .white
    ) {
        let resolvedTitle = title ?? defaultTitle
        SetConfigFlags(UInt32(FLAG_WINDOW_HIGHDPI.rawValue) | UInt32(FLAG_MSAA_4X_HINT.rawValue))
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

    private static func run(
        showFPS: Bool? = nil,
        update: () -> Void = {},
        draw: () -> Void,
        unload: () -> Void = {}
    ) {
        Key.setExitKey(.escape)
        let resolvedShowFPS = showFPS ?? defaultShowFPS
        
#if !SS_MINIMAL && !SS_NO_IMGUI
        if imguiEnabled && !ImGuiCore.isInitialized {
            ImGuiCore.initialize(theme: imguiTheme, glslVersion: imguiGlslVersion)
        }
#endif
        
        while !WindowShouldClose() {
            update()
            Render.beginDrawing()
            if let color = App.backgroundColor {
                Render.clearBackground(color)
            }
#if !SS_MINIMAL && !SS_NO_IMGUI
            if imguiEnabled {
                ImGuiCore.newFrame()
            }
#endif
            draw()
            if resolvedShowFPS {
                Render.drawFPS(x: 10, y: 10)
            }
#if !SS_MINIMAL && !SS_NO_IMGUI
            if imguiEnabled {
                ImGuiCore.render()
            }
#endif
            Render.endDrawing()
        }
        unload()
#if !SS_MINIMAL && !SS_NO_IMGUI
        if imguiEnabled {
            ImGuiCore.shutdown()
        }
#endif
        CloseWindow()
    }

    public static func run(sketch: Sketch) {
        sketch.setup()

        if !IsWindowReady() {
            App.initWindow()
        }

        App.run(
            update: { sketch.update() },
            draw: { sketch.draw() }
        )
    }
}
