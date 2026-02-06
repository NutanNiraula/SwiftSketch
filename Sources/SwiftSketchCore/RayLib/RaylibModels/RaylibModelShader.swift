import CRaylib

public extension CRaylib.Shader {
    init(handle: Int, locs: UnsafeMutablePointer<Int32>? = nil) {
        self = CRaylib.Shader(id: UInt32(handle), locs: locs)
    }
    
    var isValid: Bool {
        id != 0
    }
}
