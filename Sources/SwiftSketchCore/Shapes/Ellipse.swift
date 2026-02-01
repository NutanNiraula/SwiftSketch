
public func circle(_ x: Int,_ y: Int, radius: Double, color: Color) {
    DrawCircle(Int32(x), Int32(y), Float(radius), color)
}

public func circleV(_ position: Vector2, radius: Double, color: Color) {
    DrawCircleV(position, Float(radius), color)
}
