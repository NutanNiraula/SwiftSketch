import CRaylib

public extension MaterialMap {
    init(texture: Texture2D, color: Color, value: Double = 1.0) {
        self.init()
        self.texture = texture
        self.color = color
        self.value = Float(value)
    }
    
    func withTexture(_ texture: Texture2D) -> MaterialMap {
        MaterialMap(texture: texture, color: color, value: Double(value))
    }
}
