
import CRaylib

public enum Text {
    public static func draw(_ text: String, x: Int, y: Int, size: Int = 18, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawText(text, Int32(x), Int32(y), Int32(size), fillColor)
    }
    
    public static func draw(_ text: String, xy: Vector2, size: Int = 18, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawText(text, Int32(xy.x), Int32(xy.y), Int32(size), fillColor)
    }
    
    public static func measure(_ text: String, size: Int = 18) -> Int {
        Int(MeasureText(text, Int32(size)))
    }
}
