import CRaylib

public extension RenderTexture {
    init(id: Int, texture: CRaylib.Texture, depth: CRaylib.Texture) {
        self.init()
        self.id = UInt32(id)
        self.texture = texture
        self.depth = depth
    }
    
    var size: Vector2 {
        Vector2(Double(texture.width), Double(texture.height))
    }
}
