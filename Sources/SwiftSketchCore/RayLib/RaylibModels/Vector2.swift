import CRaylib

public extension Vector2 {
    init(_ value: Double) {
        self.init(x: Float(value), y: Float(value))
    }

    init(_ x: Int, _ y: Int) {
        self.init(x: Float(x), y: Float(y))
    }
    
    init(_ x: Double, _ y: Double) {
        self.init(x: Float(x), y: Float(y))
    }
    
    static var zero = Vector2Zero()
    static var one = Vector2One()
    
    static func windowSize() -> Vector2 {
        Vector2(App.screenWidth, App.screenHeight)
    }
    
    static func midWindow() -> Vector2 {
        Vector2(Double(App.screenWidth) / 2, Double(App.screenHeight) / 2)
    }
    
    static func midWindowHeight() -> Vector2 {
        Vector2(0.0, Double(App.screenHeight) / 2)
    }
    
    static func midWindowWidth() -> Vector2 {
        Vector2(Double(App.screenWidth) / 2, 0.0)
    }
    
    static func square(_ val: Double) -> Vector2 {
        Vector2(val, val)
    }
    
    static func width(_ val: Double) -> Vector2 {
        Vector2(val, 0.0)
    }
    
    static func height(_ val: Double) -> Vector2 {
        Vector2(0.0, val)
    }

    func rounded() -> Vector2 {
        Vector2(Double(x.rounded()), Double(y.rounded()))
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
        return Vector2(Double(lhs.x / value), Double(lhs.y / value))
    }
    
    static func /=(lhs: inout Vector2, rhs: Vector2) {
        lhs = Vector2Divide(lhs, rhs)
    }
    
    static func /=(lhs: inout Vector2, scalar: Double) {
        lhs = lhs / scalar
    }
    
    static prefix func -(vector: Vector2) -> Vector2 {
        return Vector2(Double(-vector.x), Double(-vector.y))
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

extension Vector2: @retroactive ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Double
    
    /// Convenience for prototyping.
    /// - Warning: Array literals allocate and are slower in hot paths. Prefer Vector2(x, y).
    public init(arrayLiteral elements: Double...) {
        guard elements.count == 2 else {
            fatalError("Vector2 array literal expects exactly 2 values [x, y].")
        }
        self.init(elements[0], elements[1])
    }
}