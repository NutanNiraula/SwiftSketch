import CRaylib

public extension Image {
    init(width: Int, height: Int, mipmaps: Int = 1, format: Int, data: UnsafeMutableRawPointer? = nil) {
        self.init(
            data: data,
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
