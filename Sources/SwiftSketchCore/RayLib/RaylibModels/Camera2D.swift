import CRaylib

public extension Camera2D {
    init(offset: Vector2 = .zero, target: Vector2 = .zero, rotation: Double = 0, zoom: Double = 1) {
        self.init(offset: offset, target: target, rotation: Float(rotation), zoom: Float(zoom))
    }
    
    func moved(by delta: Vector2) -> Camera2D {
        var next = self
        next.target = next.target + delta
        return next
    }
}
