enum DrawStyle {
    static var fillColor: Color? = .white
    static var strokeColor: Color? = .black
    static var strokeWeight: Double = 1.0
}

public func beginDrawing() {
    BeginDrawing()
}

public func endDrawing() {
    EndDrawing()
}

public func clearBackground(_ color: Color) {
    ClearBackground(color)
}

public func background(_ color: Color) {
    App.backgroundColor = color
    ClearBackground(color)
}

public func fill(_ color: Color) {
    DrawStyle.fillColor = color
}

public func noFill() {
    DrawStyle.fillColor = nil
}

public func stroke(_ color: Color) {
    DrawStyle.strokeColor = color
}

public func noStroke() {
    DrawStyle.strokeColor = nil
}

public func strokeWeight(_ weight: Double) {
    DrawStyle.strokeWeight = max(1.0, weight)
}

public enum Line {
    public static func draw(_ line: [Int], t: Double? = nil, color: Color? = nil) {
        guard line.count == 4 else {
            fatalError("Line array expects exactly 4 values [x1, y1, x2, y2].")
        }
        draw(x1: line[0], y1: line[1], x2: line[2], y2: line[3], t: t, color: color)
    }
    
    public static func draw(x1: Int, y1: Int, x2: Int, y2: Int, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        let weight = max(1.0, t ?? DrawStyle.strokeWeight)
        if weight <= 1.0 {
            DrawLine(Int32(x1), Int32(y1), Int32(x2), Int32(y2), strokeColor)
        } else {
            DrawLineEx(
                Vector2(x1, y1),
                Vector2(x2, y2),
                Float(weight),
                strokeColor
            )
        }
    }
    
    public static func draw(a: Vector2, b: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        let weight = max(1.0, t ?? DrawStyle.strokeWeight)
        if weight <= 1.0 {
            DrawLineV(a, b, strokeColor)
        } else {
            DrawLineEx(a, b, Float(weight), strokeColor)
        }
    }
}

public enum Point {
    public static func draw(_ point: [Int], size: Double? = nil, color: Color? = nil) {
        guard point.count == 2 else {
            fatalError("Point array expects exactly 2 values [x, y].")
        }
        draw(x: point[0], y: point[1], size: size, color: color)
    }
    
    public static func draw(x: Int, y: Int, size: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        let weight = max(1.0, size ?? DrawStyle.strokeWeight)
        if weight <= 1.0 {
            DrawPixel(Int32(x), Int32(y), strokeColor)
        } else {
            DrawCircle(Int32(x), Int32(y), Float(weight / 2.0), strokeColor)
        }
    }
    
    public static func draw(xy: Vector2, size: Double? = nil, color: Color? = nil) {
        draw(x: Int(xy.x), y: Int(xy.y), size: size, color: color)
    }
}

public func drawFPS(_ x: Int, _ y: Int) {
    DrawFPS(Int32(x), Int32(y))
}

public func getFPS() -> Int {
    Int(GetFPS())
}

public func setTargetFPS(_ fps: Int) {
    SetTargetFPS(Int32(fps))
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

public func timeSeconds() -> Double {
    Double(GetTime())
}
