public func beginDrawing() {
    BeginDrawing()
}

public func endDrawing() {
    EndDrawing()
}

public func clearBackground(_ color: Color) {
    ClearBackground(color)
}

public func drawFPS(_ x: Int, _ y: Int) {
    DrawFPS(Int32(x), Int32(y))
}

public func renderWidth() -> Int {
    Int(GetRenderWidth())
}

public func renderHeight() -> Int {
    Int(GetRenderHeight())
}

public func frameTime() -> Double {
    Double(GetFrameTime())
}
