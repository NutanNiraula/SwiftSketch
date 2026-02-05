public enum Circle {
    public static func draw(_ circle: [Double]) {
        guard circle.count == 3 else {
            fatalError("Circle array expects exactly 3 values [x, y, r].")
        }
        draw(x: Int(circle[0]), y: Int(circle[1]), r: circle[2])
    }
    
    public static func draw(x: Int, y: Int, r: Double) {
        if let fillColor = Render.fillColor {
            DrawCircle(Int32(x), Int32(y), Float(r), fillColor)
        }
        if let strokeColor = Render.strokeColor {
            DrawCircleLines(Int32(x), Int32(y), Float(r), strokeColor)
        }
    }
    
    public static func fill(x: Int, y: Int, r: Double, color: Color? = nil) {
        guard let fillColor = color ?? Render.fillColor else { return }
        DrawCircle(Int32(x), Int32(y), Float(r), fillColor)
    }
    
    public static func fill(_ circle: [Double], color: Color? = nil) {
        guard circle.count == 3 else {
            fatalError("Circle array expects exactly 3 values [x, y, r].")
        }
        fill(x: Int(circle[0]), y: Int(circle[1]), r: circle[2], color: color)
    }
    
    public static func line(x: Int, y: Int, r: Double, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        DrawCircleLines(Int32(x), Int32(y), Float(r), strokeColor)
    }
    
    public static func line(_ circle: [Double], color: Color? = nil) {
        guard circle.count == 3 else {
            fatalError("Circle array expects exactly 3 values [x, y, r].")
        }
        line(x: Int(circle[0]), y: Int(circle[1]), r: circle[2], color: color)
    }
    
    public static func vector(xy: Vector2, r: Double, color: Color? = nil) {
        guard let fillColor = color ?? Render.fillColor else { return }
        DrawCircleV(xy, Float(r), fillColor)
    }
    
    public static func line(xy: Vector2, r: Double, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        DrawCircleLinesV(xy, Float(r), strokeColor)
    }
    
    public static func gradient(x: Int, y: Int, r: Double, color1: Color, color2: Color) {
        DrawCircleGradient(Int32(x), Int32(y), Float(r), color1, color2)
    }
    
    public static func sector(
        xy: Vector2,
        r: Double,
        a0: Double,
        a1: Double,
        seg: Int,
        color: Color
    ) {
        DrawCircleSector(xy, Float(r), Float(a0), Float(a1), Int32(seg), color)
    }
    
    public static func sectorLine(
        xy: Vector2,
        r: Double,
        a0: Double,
        a1: Double,
        seg: Int,
        color: Color
    ) {
        DrawCircleSectorLines(xy, Float(r), Float(a0), Float(a1), Int32(seg), color)
    }
}

public enum Ring {
    public static func fill(
        xy: Vector2,
        rIn: Double,
        rOut: Double,
        a0: Double,
        a1: Double,
        seg: Int,
        color: Color
    ) {
        DrawRing(xy, Float(rIn), Float(rOut), Float(a0), Float(a1), Int32(seg), color)
    }
    
    public static func line(
        xy: Vector2,
        rIn: Double,
        rOut: Double,
        a0: Double,
        a1: Double,
        seg: Int,
        color: Color
    ) {
        DrawRingLines(xy, Float(rIn), Float(rOut), Float(a0), Float(a1), Int32(seg), color)
    }
}

public enum Ellipse {
    public static func draw(_ ellipse: [Double]) {
        guard ellipse.count == 4 else {
            fatalError("Ellipse array expects exactly 4 values [x, y, rx, ry].")
        }
        draw(x: Int(ellipse[0]), y: Int(ellipse[1]), rx: ellipse[2], ry: ellipse[3])
    }
    
    public static func draw(x: Int, y: Int, rx: Double, ry: Double) {
        if let fillColor = Render.fillColor {
            DrawEllipse(Int32(x), Int32(y), Float(rx), Float(ry), fillColor)
        }
        if let strokeColor = Render.strokeColor {
            DrawEllipseLines(Int32(x), Int32(y), Float(rx), Float(ry), strokeColor)
        }
    }
    
    public static func fill(x: Int, y: Int, rx: Double, ry: Double, color: Color? = nil) {
        guard let fillColor = color ?? Render.fillColor else { return }
        DrawEllipse(Int32(x), Int32(y), Float(rx), Float(ry), fillColor)
    }
    
    public static func fill(_ ellipse: [Double], color: Color? = nil) {
        guard ellipse.count == 4 else {
            fatalError("Ellipse array expects exactly 4 values [x, y, rx, ry].")
        }
        fill(x: Int(ellipse[0]), y: Int(ellipse[1]), rx: ellipse[2], ry: ellipse[3], color: color)
    }
    
    public static func line(x: Int, y: Int, rx: Double, ry: Double, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        DrawEllipseLines(Int32(x), Int32(y), Float(rx), Float(ry), strokeColor)
    }
    
    public static func line(_ ellipse: [Double], color: Color? = nil) {
        guard ellipse.count == 4 else {
            fatalError("Ellipse array expects exactly 4 values [x, y, rx, ry].")
        }
        line(x: Int(ellipse[0]), y: Int(ellipse[1]), rx: ellipse[2], ry: ellipse[3], color: color)
    }
    
    public static func vector(xy: Vector2, rx: Double, ry: Double, color: Color? = nil) {
        guard let fillColor = color ?? Render.fillColor else { return }
        DrawEllipseV(xy, Float(rx), Float(ry), fillColor)
    }
    
    public static func line(xy: Vector2, rx: Double, ry: Double, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        DrawEllipseLinesV(xy, Float(rx), Float(ry), strokeColor)
    }
}
