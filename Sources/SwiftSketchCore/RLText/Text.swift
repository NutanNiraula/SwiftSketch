
import CRaylib

public func text(_ text: String,_ x: Int,_ y: Int, fontSize: Int = 18, color: Color) {
    DrawText(text, Int32(x), Int32(y), Int32(fontSize), color)
}

public func textV(_ text: String,_ origin: Vector2, fontSize: Int = 18, color: Color) {
    DrawText(text, Int32(origin.x), Int32(origin.y), Int32(fontSize), color)
}
