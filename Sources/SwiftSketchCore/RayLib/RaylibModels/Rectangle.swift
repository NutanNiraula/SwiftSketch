import CRaylib

public extension Rectangle {
    init(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        self.init(x: Float(x), y: Float(y), width: Float(width), height: Float(height))
    }
    
    var center: Vector2 {
        Vector2(Double(x + width * 0.5), Double(y + height * 0.5))
    }
}
