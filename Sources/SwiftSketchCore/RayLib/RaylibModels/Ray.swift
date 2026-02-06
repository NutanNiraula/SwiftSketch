import CRaylib

public extension Ray {
    init(position: Vector3, direction: Vector3) {
        self.init()
        self.position = position
        self.direction = direction
    }
    
    func point(at distance: Double) -> Vector3 {
        Vector3(
            x: position.x + direction.x * Float(distance),
            y: position.y + direction.y * Float(distance),
            z: position.z + direction.z * Float(distance)
        )
    }
}
