import CRaylib

public extension Font {
    init(
        baseSize: Int,
        glyphCount: Int,
        glyphPadding: Int,
        texture: Texture2D,
        recs: UnsafeMutablePointer<Rectangle>?,
        glyphs: UnsafeMutablePointer<GlyphInfo>?
    ) {
        self.init()
        self.baseSize = Int32(baseSize)
        self.glyphCount = Int32(glyphCount)
        self.glyphPadding = Int32(glyphPadding)
        self.texture = texture
        self.recs = recs
        self.glyphs = glyphs
    }
    
    var isValid: Bool {
        baseSize > 0 && texture.id != 0
    }
}
