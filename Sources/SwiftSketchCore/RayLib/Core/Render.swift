public enum Render {
    static var fillColor: Color? = .white
    static var strokeColor: Color? = .black
    static var strokeWeight: Double = 1.0

    public static func beginDrawing() { BeginDrawing() }
    public static func endDrawing() { EndDrawing() }
    public static func clearBackground(_ color: Color) { ClearBackground(color) }

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
