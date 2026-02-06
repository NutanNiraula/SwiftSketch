import CRaylib

public enum CameraMode: Int32 {
    case custom = 0
    case free
    case orbital
    case firstPerson
    case thirdPerson
}

public extension CRaylib.Camera {
    func screenToWorldRay(_ position: Vector2) -> CRaylib.Ray {
        GetScreenToWorldRay(position, self)
    }
    
    func screenToWorldRay(_ position: Vector2, width: Int, height: Int) -> CRaylib.Ray {
        GetScreenToWorldRayEx(position, self, Int32(width), Int32(height))
    }
    
    func worldToScreen(_ position: Vector3) -> Vector2 {
        GetWorldToScreen(position, self)
    }
    
    func worldToScreen(_ position: Vector3, width: Int, height: Int) -> Vector2 {
        GetWorldToScreenEx(position, self, Int32(width), Int32(height))
    }
    
    func matrix() -> Matrix {
        GetCameraMatrix(self)
    }
    
    mutating func update(mode: CameraMode) {
        withUnsafeMutablePointer(to: &self) { UpdateCamera($0, Int32(mode.rawValue)) }
    }
    
    mutating func update(movement: Vector3, rotation: Vector3, zoom: Double) {
        withUnsafeMutablePointer(to: &self) { UpdateCameraPro($0, movement, rotation, Float(zoom)) }
    }
}

public extension Camera2D {
    func worldToScreen(_ position: Vector2) -> Vector2 {
        GetWorldToScreen2D(position, self)
    }
    
    func screenToWorld(_ position: Vector2) -> Vector2 {
        GetScreenToWorld2D(position, self)
    }
    
    func matrix() -> Matrix {
        GetCameraMatrix2D(self)
    }
}
