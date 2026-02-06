public enum Render {
    static var fillColor: Color? = .white
    static var strokeColor: Color? = .black
    static var strokeWeight: Double = 1.0

    public static func beginDrawing() { BeginDrawing() }
    public static func endDrawing() { EndDrawing() }
    public static func clearBackground(_ color: Color) { ClearBackground(color) }
    public static func beginMode2D(_ camera: Camera2D) { BeginMode2D(camera) }
    public static func endMode2D() { EndMode2D() }
    public static func beginMode3D(_ camera: CRaylib.Camera) { BeginMode3D(camera) }
    public static func endMode3D() { EndMode3D() }
    public static func beginTextureMode(_ target: RenderTexture2D) { BeginTextureMode(target) }
    public static func endTextureMode() { EndTextureMode() }
    public static func beginBlendMode(_ mode: Int) { BeginBlendMode(Int32(mode)) }
    public static func endBlendMode() { EndBlendMode() }
    public static func beginScissorMode(x: Int, y: Int, width: Int, height: Int) {
        BeginScissorMode(Int32(x), Int32(y), Int32(width), Int32(height))
    }
    public static func endScissorMode() { EndScissorMode() }

    public static func background(_ color: Color) {
        App.backgroundColor = color
        ClearBackground(color)
    }

    public static func fill(_ color: Color) { fillColor = color }
    public static func noFill() { fillColor = nil }
    public static func stroke(_ color: Color) { strokeColor = color }
    public static func noStroke() { strokeColor = nil }
    public static func strokeWeight(_ weight: Double) { strokeWeight = max(1.0, weight) }

    public static func drawFPS(x: Int, y: Int) { DrawFPS(Int32(x), Int32(y)) }
    public static func getFPS() -> Int { Int(GetFPS()) }
    public static func setTargetFPS(_ fps: Int) { SetTargetFPS(Int32(fps)) }
    public static func renderWidth() -> Int { Int(GetRenderWidth()) }
    public static func renderHeight() -> Int { Int(GetRenderHeight()) }
    public static func frameTime() -> Double { Double(GetFrameTime()) }
    public static func timeSeconds() -> Double { Double(GetTime()) }
}
