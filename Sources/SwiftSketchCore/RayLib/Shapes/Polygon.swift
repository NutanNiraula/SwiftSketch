public enum Triangle {
    public static func draw(a: Vector2, b: Vector2, c: Vector2) {
        if let fillColor = DrawStyle.fillColor {
            DrawTriangle(a, b, c, fillColor)
        }
        if let strokeColor = DrawStyle.strokeColor {
            DrawTriangleLines(a, b, c, strokeColor)
        }
    }
    
    public static func fill(a: Vector2, b: Vector2, c: Vector2, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawTriangle(a, b, c, fillColor)
    }
    
    public static func line(a: Vector2, b: Vector2, c: Vector2, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        DrawTriangleLines(a, b, c, strokeColor)
    }
}

public enum Quad {
    public static func draw(a: Vector2, b: Vector2, c: Vector2, d: Vector2) {
        if let fillColor = DrawStyle.fillColor {
            DrawTriangle(a, b, c, fillColor)
            DrawTriangle(a, c, d, fillColor)
        }
        if let strokeColor = DrawStyle.strokeColor {
            let weight = max(1.0, DrawStyle.strokeWeight)
            if weight <= 1.0 {
                DrawLineV(a, b, strokeColor)
                DrawLineV(b, c, strokeColor)
                DrawLineV(c, d, strokeColor)
                DrawLineV(d, a, strokeColor)
            } else {
                DrawLineEx(a, b, Float(weight), strokeColor)
                DrawLineEx(b, c, Float(weight), strokeColor)
                DrawLineEx(c, d, Float(weight), strokeColor)
                DrawLineEx(d, a, Float(weight), strokeColor)
            }
        }
    }
    
    public static func fill(a: Vector2, b: Vector2, c: Vector2, d: Vector2, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawTriangle(a, b, c, fillColor)
        DrawTriangle(a, c, d, fillColor)
    }
    
    public static func line(a: Vector2, b: Vector2, c: Vector2, d: Vector2, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        let weight = max(1.0, t ?? DrawStyle.strokeWeight)
        if weight <= 1.0 {
            DrawLineV(a, b, strokeColor)
            DrawLineV(b, c, strokeColor)
            DrawLineV(c, d, strokeColor)
            DrawLineV(d, a, strokeColor)
        } else {
            DrawLineEx(a, b, Float(weight), strokeColor)
            DrawLineEx(b, c, Float(weight), strokeColor)
            DrawLineEx(c, d, Float(weight), strokeColor)
            DrawLineEx(d, a, Float(weight), strokeColor)
        }
    }
}

public enum PolygonPath {
    case closed
    case open
}

@resultBuilder
public struct PolygonBuilder {
    public static func buildBlock(_ components: [Vector2]...) -> [Vector2] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: Vector2) -> [Vector2] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [Vector2]) -> [Vector2] {
        expression
    }
    
    public static func buildOptional(_ component: [Vector2]?) -> [Vector2] {
        component ?? []
    }
    
    public static func buildEither(first component: [Vector2]) -> [Vector2] {
        component
    }
    
    public static func buildEither(second component: [Vector2]) -> [Vector2] {
        component
    }
    
    public static func buildArray(_ components: [[Vector2]]) -> [Vector2] {
        components.flatMap { $0 }
    }
    
    public static func buildLimitedAvailability(_ component: [Vector2]) -> [Vector2] {
        component
    }
}

public enum Polygon {
    public static func callAsFunction(
        _ kind: PolygonPath = .closed,
        t: Double? = nil,
        @PolygonBuilder _ points: () -> [Vector2]
    ) {
        let resolved = points()
        if kind == .closed, let fillColor = DrawStyle.fillColor {
            fillTriangles(points: resolved, color: fillColor)
        }
        if let strokeColor = DrawStyle.strokeColor {
            let weight = max(1.0, t ?? DrawStyle.strokeWeight)
            strokeLines(points: resolved, closed: kind == .closed, weight: weight, color: strokeColor)
        }
    }
    
    public static func fill(
        _ kind: PolygonPath = .closed,
        color: Color,
        @PolygonBuilder _ points: () -> [Vector2]
    ) {
        guard kind == .closed else { return }
        fillTriangles(points: points(), color: color)
    }
    
    public static func line(
        _ kind: PolygonPath = .closed,
        t: Double = 1.0,
        color: Color,
        @PolygonBuilder _ points: () -> [Vector2]
    ) {
        let weight = max(1.0, t)
        strokeLines(points: points(), closed: kind == .closed, weight: weight, color: color)
    }
    
    public static func draw(xy: Vector2, sides: Int, r: Double, rot: Double = 0) {
        if let fillColor = DrawStyle.fillColor {
            DrawPoly(xy, Int32(sides), Float(r), Float(rot), fillColor)
        }
        if let strokeColor = DrawStyle.strokeColor {
            DrawPolyLines(xy, Int32(sides), Float(r), Float(rot), strokeColor)
        }
    }
    
    public static func fill(xy: Vector2, sides: Int, r: Double, rot: Double = 0, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawPoly(xy, Int32(sides), Float(r), Float(rot), fillColor)
    }
    
    public static func line(xy: Vector2, sides: Int, r: Double, rot: Double = 0, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        let weight = max(1.0, t ?? DrawStyle.strokeWeight)
        if weight <= 1.0 {
            DrawPolyLines(xy, Int32(sides), Float(r), Float(rot), strokeColor)
        } else {
            DrawPolyLinesEx(xy, Int32(sides), Float(r), Float(rot), Float(weight), strokeColor)
        }
    }
    
    private static func fillTriangles(points: [Vector2], color: Color) {
        guard points.count >= 3 else { return }
        let p0 = points[0]
        for index in 1..<(points.count - 1) {
            DrawTriangle(p0, points[index], points[index + 1], color)
        }
    }
    
    private static func strokeLines(points: [Vector2], closed: Bool, weight: Double, color: Color) {
        guard points.count >= 2 else { return }
        if weight <= 1.0 {
            for index in 0..<(points.count - 1) {
                DrawLineV(points[index], points[index + 1], color)
            }
            if closed {
                DrawLineV(points[points.count - 1], points[0], color)
            }
        } else {
            for index in 0..<(points.count - 1) {
                DrawLineEx(points[index], points[index + 1], Float(weight), color)
            }
            if closed {
                DrawLineEx(points[points.count - 1], points[0], Float(weight), color)
            }
        }
    }
}
