public enum Collision {
    public static func recs(_ a: Rectangle, _ b: Rectangle) -> Bool {
        CheckCollisionRecs(a, b)
    }
    
    public static func recs(_ a: [Int], _ b: [Int]) -> Bool {
        guard a.count == 4 else {
            fatalError("Rect array expects exactly 4 values [x, y, w, h].")
        }
        guard b.count == 4 else {
            fatalError("Rect array expects exactly 4 values [x, y, w, h].")
        }
        let ra = Rectangle(x: Float(a[0]), y: Float(a[1]), width: Float(a[2]), height: Float(a[3]))
        let rb = Rectangle(x: Float(b[0]), y: Float(b[1]), width: Float(b[2]), height: Float(b[3]))
        return recs(ra, rb)
    }
    
    public static func circles(centerA: Vector2, radiusA: Double, centerB: Vector2, radiusB: Double) -> Bool {
        CheckCollisionCircles(centerA, Float(radiusA), centerB, Float(radiusB))
    }
    
    public static func circles(_ a: [Double], _ b: [Double]) -> Bool {
        guard a.count == 3 else {
            fatalError("Circle array expects exactly 3 values [x, y, r].")
        }
        guard b.count == 3 else {
            fatalError("Circle array expects exactly 3 values [x, y, r].")
        }
        return circles(
            centerA: Vector2(a[0], a[1]),
            radiusA: a[2],
            centerB: Vector2(b[0], b[1]),
            radiusB: b[2]
        )
    }
    
    public static func circleRec(center: Vector2, radius: Double, rec: Rectangle) -> Bool {
        CheckCollisionCircleRec(center, Float(radius), rec)
    }
    
    public static func circleRec(_ circle: [Double], _ rec: Rectangle) -> Bool {
        guard circle.count == 3 else {
            fatalError("Circle array expects exactly 3 values [x, y, r].")
        }
        return circleRec(center: Vector2(circle[0], circle[1]), radius: circle[2], rec: rec)
    }
    
    public static func circleLine(center: Vector2, radius: Double, a: Vector2, b: Vector2) -> Bool {
        CheckCollisionCircleLine(center, Float(radius), a, b)
    }
    
    public static func pointRec(_ point: Vector2, _ rec: Rectangle) -> Bool {
        CheckCollisionPointRec(point, rec)
    }
    
    public static func pointCircle(_ point: Vector2, center: Vector2, radius: Double) -> Bool {
        CheckCollisionPointCircle(point, center, Float(radius))
    }
    
    public static func pointTriangle(_ point: Vector2, _ a: Vector2, _ b: Vector2, _ c: Vector2) -> Bool {
        CheckCollisionPointTriangle(point, a, b, c)
    }
    
    public static func pointLine(_ point: Vector2, _ a: Vector2, _ b: Vector2, threshold: Int) -> Bool {
        CheckCollisionPointLine(point, a, b, Int32(threshold))
    }
    
    public static func pointPoly(_ point: Vector2, _ points: [Vector2]) -> Bool {
        guard !points.isEmpty else { return false }
        return points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return false }
            return CheckCollisionPointPoly(point, base, Int32(buffer.count))
        }
    }
    
    public static func lines(
        _ a0: Vector2,
        _ a1: Vector2,
        _ b0: Vector2,
        _ b1: Vector2,
        collision: UnsafeMutablePointer<Vector2>? = nil
    ) -> Bool {
        CheckCollisionLines(a0, a1, b0, b1, collision)
    }
    
    public static func rect(_ a: Rectangle, _ b: Rectangle) -> Rectangle {
        GetCollisionRec(a, b)
    }
}
