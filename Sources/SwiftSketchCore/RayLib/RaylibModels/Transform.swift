import CRaylib

public extension Transform {
    init(translation: Vector3, rotation: Quaternion, scale: Vector3) {
        self.init()
        self.translation = translation
        self.rotation = rotation
        self.scale = scale
    }
    
    func moved(by delta: Vector3) -> Transform {
        var next = self
        next.translation = Vector3(
            x: next.translation.x + delta.x,
            y: next.translation.y + delta.y,
            z: next.translation.z + delta.z
        )
        return next
    }
}
