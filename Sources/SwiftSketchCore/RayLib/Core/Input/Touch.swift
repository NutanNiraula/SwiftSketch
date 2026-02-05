public enum Touch {
    public static func x() -> Int {
        Int(GetTouchX())
    }
    
    public static func y() -> Int {
        Int(GetTouchY())
    }
    
    public static func position(_ index: Int = 0) -> Vector2 {
        GetTouchPosition(Int32(index))
    }
    
    public static func pointId(_ index: Int) -> Int {
        Int(GetTouchPointId(Int32(index)))
    }
    
    public static func pointCount() -> Int {
        Int(GetTouchPointCount())
    }
}
