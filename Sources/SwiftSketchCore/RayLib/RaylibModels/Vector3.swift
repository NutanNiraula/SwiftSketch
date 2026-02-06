import CRaylib

public extension Vector3 {
    init(_ x: Double, _ y: Double, _ z: Double) {
        self.init(x: Float(x), y: Float(y), z: Float(z))
    }
    
    func rounded() -> Vector3 {
        Vector3(Double(x.rounded()), Double(y.rounded()), Double(z.rounded()))
    }
}
