import CRaylib

public extension CRaylib.Texture {
    init(handle: Int, width: Int, height: Int, mipmaps: Int = 1, format: Int) {
        self = CRaylib.Texture(
            id: UInt32(handle),
            width: Int32(width),
            height: Int32(height),
            mipmaps: Int32(mipmaps),
            format: Int32(format)
        )
    }
    
    var size: Vector2 {
        Vector2(Double(width), Double(height))
    }
}
