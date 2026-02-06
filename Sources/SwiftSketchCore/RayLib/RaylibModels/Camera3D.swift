import CRaylib

public extension Camera3D {
    init(
        position: Vector3,
        target: Vector3,
        up: Vector3 = Vector3(x: 0, y: 1, z: 0),
        fovy: Double = 45.0,
        projection: Int = 0
    ) {
        self.init(
            position: position,
            target: target,
            up: up,
            fovy: Float(fovy),
            projection: Int32(projection)
        )
    }
    
    func moved(by delta: Vector3) -> Camera3D {
        var next = self
        next.position = Vector3(
            x: next.position.x + delta.x,
            y: next.position.y + delta.y,
            z: next.position.z + delta.z
        )
        next.target = Vector3(
            x: next.target.x + delta.x,
            y: next.target.y + delta.y,
            z: next.target.z + delta.z
        )
        return next
    }
}
