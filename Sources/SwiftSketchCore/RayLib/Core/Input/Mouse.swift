
public enum MouseButton: Int {
    /// Mouse button left
    case left    = 0
    /// Mouse button right
    case right   = 1
    /// Mouse button middle (pressed wheel)
    case middle  = 2
    /// Mouse button side (advanced mouse device)
    case side    = 3
    /// Mouse button extra (advanced mouse device)
    case extra   = 4
    /// Mouse button fordward (advanced mouse device)
    case forward = 5
    /// Mouse button back (advanced mouse device)
    case back    = 6
}

public enum MouseCursor: Int {
    case `default` = 0
    case arrow = 1
    case ibeam = 2
    case crosshair = 3
    case pointingHand = 4
    case resizeEW = 5
    case resizeNS = 6
    case resizeNWSE = 7
    case resizeNESW = 8
    case resizeAll = 9
    case notAllowed = 10
}

public enum Mouse {
    public static func isButtonPressed(_ button: MouseButton) -> Bool { IsMouseButtonPressed(Int32(button.rawValue)) }
    public static func isButtonDown(_ button: MouseButton) -> Bool { IsMouseButtonDown(Int32(button.rawValue)) }
    public static func isButtonReleased(_ button: MouseButton) -> Bool { IsMouseButtonReleased(Int32(button.rawValue)) }
    public static func isButtonUp(_ button: MouseButton) -> Bool { IsMouseButtonUp(Int32(button.rawValue)) }
    public static func position() -> Vector2 { GetMousePosition() }
    public static func delta() -> Vector2 { GetMouseDelta() }
    public static func x() -> Int { Int(GetMouseX()) }
    public static func y() -> Int { Int(GetMouseY()) }
    public static func setPosition(x: Int, y: Int) { SetMousePosition(Int32(x), Int32(y)) }
    public static func setOffset(x: Int, y: Int) { SetMouseOffset(Int32(x), Int32(y)) }
    public static func setScale(x: Double, y: Double) { SetMouseScale(Float(x), Float(y)) }
    public static func wheelMove() -> Double { Double(GetMouseWheelMove()) }
    public static func wheelMoveV() -> Vector2 { GetMouseWheelMoveV() }
    public static func setCursor(_ cursor: MouseCursor) { SetMouseCursor(Int32(cursor.rawValue)) }
    public static func showCursor() { ShowCursor() }
    public static func hideCursor() { HideCursor() }
    public static func isCursorHidden() -> Bool { IsCursorHidden() }
    public static func enableCursor() { EnableCursor() }
    public static func disableCursor() { DisableCursor() }
    public static func isCursorOnScreen() -> Bool { IsCursorOnScreen() }
}
