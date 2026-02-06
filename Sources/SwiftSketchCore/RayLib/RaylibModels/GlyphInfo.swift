import CRaylib

public extension GlyphInfo {
    init(value: Int, offsetX: Int, offsetY: Int, advanceX: Int, image: Image) {
        self.init()
        self.value = Int32(value)
        self.offsetX = Int32(offsetX)
        self.offsetY = Int32(offsetY)
        self.advanceX = Int32(advanceX)
        self.image = image
    }
    
    var offset: Vector2 {
        Vector2(Double(offsetX), Double(offsetY))
    }
}
