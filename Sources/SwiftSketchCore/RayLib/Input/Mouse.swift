
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

public func isMouseButtonPressed(_ button: MouseButton) -> Bool {
    IsMouseButtonPressed(Int32(button.rawValue))
}

public func isMouseButtonDown(_ button: MouseButton) -> Bool {
    IsMouseButtonDown(Int32(button.rawValue))
}

public func isMouseButtonReleased(_ button: MouseButton) -> Bool {
    IsMouseButtonReleased(Int32(button.rawValue))
}

public func isMouseButtonUp(_ button: MouseButton) -> Bool {
    IsMouseButtonUp(Int32(button.rawValue))
}

public func getMousePosition() -> Vector2 {
    GetMousePosition()
}

public func getMouseDelta() -> Vector2 {
    GetMouseDelta()
}

public func getMouseX() -> Int {
    Int(GetMouseX())
}

public func getMouseY() -> Int {
    Int(GetMouseY())
}

public func setMousePosition(x: Int, y: Int) {
    SetMousePosition(Int32(x), Int32(y))
}

public func setMouseOffset(x: Int, y: Int) {
    SetMouseOffset(Int32(x), Int32(y))
}

public func setMouseScale(x: Double, y: Double) {
    SetMouseScale(Float(x), Float(y))
}

public func getMouseWheelMove() -> Double {
    Double(GetMouseWheelMove())
}

public func getMouseWheelMoveV() -> Vector2 {
    GetMouseWheelMoveV()
}

public func setMouseCursor(_ cursor: MouseCursor) {
    SetMouseCursor(Int32(cursor.rawValue))
}

public func showCursor() {
    ShowCursor()
}

public func hideCursor() {
    HideCursor()
}

public func isCursorHidden() -> Bool {
    IsCursorHidden()
}

public func enableCursor() {
    EnableCursor()
}

public func disableCursor() {
    DisableCursor()
}

public func isCursorOnScreen() -> Bool {
    IsCursorOnScreen()
}
