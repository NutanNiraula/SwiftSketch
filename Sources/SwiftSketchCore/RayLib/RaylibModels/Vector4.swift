import CRaylib

public extension Vector4 {
    init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.init(x: Float(x), y: Float(y), z: Float(z), w: Float(w))
    }
    
    func dot(_ other: Vector4) -> Double {
        Double(x * other.x + y * other.y + z * other.z + w * other.w)
    }
}
