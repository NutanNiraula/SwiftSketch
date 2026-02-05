public enum Line {
    public static func draw(_ line: [Int], t: Double? = nil, color: Color? = nil) {
        guard line.count == 4 else {
            fatalError("Line array expects exactly 4 values [x1, y1, x2, y2].")
        }
        draw(x1: line[0], y1: line[1], x2: line[2], y2: line[3], t: t, color: color)
    }

    public static func draw(x1: Int, y1: Int, x2: Int, y2: Int, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
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
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        if weight <= 1.0 {
            DrawLineV(a, b, strokeColor)
        } else {
            DrawLineEx(a, b, Float(weight), strokeColor)
        }
    }
    
    public static func strip(_ points: [Vector2], color: Color? = nil) {
        guard points.count >= 2 else { return }
        guard let strokeColor = color ?? Render.strokeColor else { return }
        points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawLineStrip(base, Int32(buffer.count), strokeColor)
        }
    }
    
    public static func bezier(start: Vector2, end: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        DrawLineBezier(start, end, Float(weight), strokeColor)
    }
    
    public static func dashed(
        start: Vector2,
        end: Vector2,
        dash: Int,
        space: Int,
        color: Color? = nil
    ) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        DrawLineDashed(start, end, Int32(dash), Int32(space), strokeColor)
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
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, size ?? Render.strokeWeight)
        if weight <= 1.0 {
            DrawPixel(Int32(x), Int32(y), strokeColor)
        } else {
            DrawCircle(Int32(x), Int32(y), Float(weight / 2.0), strokeColor)
        }
    }

    public static func draw(xy: Vector2, size: Double? = nil, color: Color? = nil) {
        draw(x: Int(xy.x), y: Int(xy.y), size: size, color: color)
    }
    
    public static func pixel(xy: Vector2, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        DrawPixelV(xy, strokeColor)
    }
}

public enum Spline {
    public static func linear(_ points: [Vector2], t: Double? = nil, color: Color? = nil) {
        guard points.count >= 2 else { return }
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawSplineLinear(base, Int32(buffer.count), Float(weight), strokeColor)
        }
    }
    
    public static func basis(_ points: [Vector2], t: Double? = nil, color: Color? = nil) {
        guard points.count >= 4 else { return }
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawSplineBasis(base, Int32(buffer.count), Float(weight), strokeColor)
        }
    }
    
    public static func catmullRom(_ points: [Vector2], t: Double? = nil, color: Color? = nil) {
        guard points.count >= 4 else { return }
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawSplineCatmullRom(base, Int32(buffer.count), Float(weight), strokeColor)
        }
    }
    
    public static func bezierQuadratic(_ points: [Vector2], t: Double? = nil, color: Color? = nil) {
        guard points.count >= 3 else { return }
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawSplineBezierQuadratic(base, Int32(buffer.count), Float(weight), strokeColor)
        }
    }
    
    public static func bezierCubic(_ points: [Vector2], t: Double? = nil, color: Color? = nil) {
        guard points.count >= 4 else { return }
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawSplineBezierCubic(base, Int32(buffer.count), Float(weight), strokeColor)
        }
    }
    
    public static func segmentLinear(_ p1: Vector2, _ p2: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        DrawSplineSegmentLinear(p1, p2, Float(weight), strokeColor)
    }
    
    public static func segmentBasis(_ p1: Vector2, _ p2: Vector2, _ p3: Vector2, _ p4: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        DrawSplineSegmentBasis(p1, p2, p3, p4, Float(weight), strokeColor)
    }
    
    public static func segmentCatmullRom(_ p1: Vector2, _ p2: Vector2, _ p3: Vector2, _ p4: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        DrawSplineSegmentCatmullRom(p1, p2, p3, p4, Float(weight), strokeColor)
    }
    
    public static func segmentBezierQuadratic(_ p1: Vector2, _ c2: Vector2, _ p3: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        DrawSplineSegmentBezierQuadratic(p1, c2, p3, Float(weight), strokeColor)
    }
    
    public static func segmentBezierCubic(_ p1: Vector2, _ c2: Vector2, _ c3: Vector2, _ p4: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? Render.strokeColor else { return }
        let weight = max(1.0, t ?? Render.strokeWeight)
        DrawSplineSegmentBezierCubic(p1, c2, c3, p4, Float(weight), strokeColor)
    }
    
    public static func pointLinear(_ start: Vector2, _ end: Vector2, t: Double) -> Vector2 {
        GetSplinePointLinear(start, end, Float(t))
    }
    
    public static func pointBasis(_ p1: Vector2, _ p2: Vector2, _ p3: Vector2, _ p4: Vector2, t: Double) -> Vector2 {
        GetSplinePointBasis(p1, p2, p3, p4, Float(t))
    }
    
    public static func pointCatmullRom(_ p1: Vector2, _ p2: Vector2, _ p3: Vector2, _ p4: Vector2, t: Double) -> Vector2 {
        GetSplinePointCatmullRom(p1, p2, p3, p4, Float(t))
    }
    
    public static func pointBezierQuadratic(_ p1: Vector2, _ c2: Vector2, _ p3: Vector2, t: Double) -> Vector2 {
        GetSplinePointBezierQuad(p1, c2, p3, Float(t))
    }
    
    public static func pointBezierCubic(_ p1: Vector2, _ c2: Vector2, _ c3: Vector2, _ p4: Vector2, t: Double) -> Vector2 {
        GetSplinePointBezierCubic(p1, c2, c3, p4, Float(t))
    }
}
