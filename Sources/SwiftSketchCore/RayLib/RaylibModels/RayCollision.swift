import CRaylib

public extension RayCollision {
    init(hit: Bool, distance: Double, point: Vector3, normal: Vector3) {
        self.init()
        self.hit = hit
        self.distance = Float(distance)
        self.point = point
        self.normal = normal
    }
    
    var isHit: Bool { hit }
}
