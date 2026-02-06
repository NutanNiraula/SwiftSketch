import CRaylib

public extension BoundingBox {
    init(min: Vector3, max: Vector3) {
        self.init()
        self.min = min
        self.max = max
    }
    
    func contains(_ point: Vector3) -> Bool {
        point.x >= min.x && point.x <= max.x &&
        point.y >= min.y && point.y <= max.y &&
        point.z >= min.z && point.z <= max.z
    }
}
