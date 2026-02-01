import CRaylib

public extension Vector2 {
    static var zero = Vector2Zero()
    static var one = Vector2One()
    
    static func windowSize() -> Vector2 {
        Vector2(x: Float(App.screenWidth), y: Float(App.screenHeight))
    }
    
    static func midWindow() -> Vector2 {
        Vector2(x: Float(App.screenWidth)/2, y: Float(App.screenHeight)/2)
    }
    
    static func midWindowHeight() -> Vector2 {
        Vector2(x: 0.0, y: Float(App.screenHeight)/2)
    }
    
    static func midWindowWidth() -> Vector2 {
        Vector2(x: Float(App.screenWidth)/2, y: 0.0)
    }
    
    static func square(_ val: Double) -> Vector2 {
        Vector2(x: Float(val), y: Float(val))
    }
    
    static func width(_ val: Double) -> Vector2 {
        Vector2(x: Float(val), y: 0.0)
    }
    
    static func height(_ val: Double) -> Vector2 {
        Vector2(x: 0.0, y: Float(val))
    }
    
    static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2Add(lhs, rhs)
    }
    
    static func +(lhs: Vector2, rhs: Double) -> Vector2 {
        return Vector2AddValue(lhs, Float(rhs))
    }
    
    static func +=(lhs: inout Vector2, rhs: Vector2) {
        lhs = Vector2Add(lhs, rhs)
    }
    
    static func +=(lhs: inout Vector2, rhs: Double) {
        lhs = Vector2AddValue(lhs, Float(rhs))
    }
    
    static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2Subtract(lhs, rhs)
    }
    
    static func -(lhs: Vector2, rhs: Double) -> Vector2 {
        return Vector2SubtractValue(lhs, Float(rhs))
    }
    
    static func -=(lhs: inout Vector2, rhs: Vector2) {
        lhs = Vector2Subtract(lhs, rhs)
    }
    
    static func -=(lhs: inout Vector2, rhs: Double) {
        lhs = Vector2SubtractValue(lhs, Float(rhs))
    }
    
    static func *(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2Multiply(lhs, rhs)
    }
    
    static func *(lhs: Vector2, rhs: Double) -> Vector2 {
        return Vector2Scale(lhs, Float(rhs))
    }
    
    static func *=(lhs: inout Vector2, rhs: Vector2) {
        lhs = Vector2Multiply(lhs, rhs)
    }
    
    static func *=(lhs: inout Vector2, rhs: Double) {
        lhs = Vector2Scale(lhs, Float(rhs))
    }
    
    static func /(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2Divide(lhs, rhs)
    }
    
    static func /(lhs: Vector2, scalar: Double) -> Vector2 {
        let value = Float(scalar)
        return Vector2(x: lhs.x / value, y: lhs.y / value)
    }
    
    static func /=(lhs: inout Vector2, rhs: Vector2) {
        lhs = Vector2Divide(lhs, rhs)
    }
    
    static func /=(lhs: inout Vector2, scalar: Double) {
        lhs = lhs / scalar
    }
    
    static prefix func -(vector: Vector2) -> Vector2 {
        return Vector2(x: -vector.x, y: -vector.y)
    }
    
    func magnitude() -> Double { Double(Vector2Length(self)) }
    
    func magnitudeSqr() -> Double { Double(Vector2LengthSqr(self)) }
    
    func distance(to vector: Vector2) -> Double { Double(Vector2Distance(self, vector)) }
    
    func distanceSqr(to vector: Vector2) -> Double { Double(Vector2DistanceSqr(self, vector)) }
    
    func dotProduct(with vector: Vector2) -> Double { Double(Vector2DotProduct(self, vector)) }
    
    func angle(between vector: Vector2) -> Double { Double(Vector2Angle(self, vector)) }
    
    func normalized() -> Vector2 { Vector2Normalize(self) }
    
    func transformed(by matrix: Matrix) -> Vector2 { Vector2Transform(self, matrix) }
    
    func lerp(to vector: Vector2, _ amount: Double) -> Vector2 { Vector2Lerp(self, vector, Float(amount)) }
    
    func reflected(toNormal: Vector2) -> Vector2 { Vector2Reflect(self, toNormal) }
}

public extension Vector3 {
    static var zero = Vector3Zero()
    static var one = Vector3One()
}
