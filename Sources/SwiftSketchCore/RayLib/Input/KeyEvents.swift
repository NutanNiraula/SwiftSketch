  
/// Check if a key has been pressed once
public func isKeyPressed(_ key: Key) -> Bool { IsKeyPressed(Int32(key.rawValue)) }

/// Check if a key has been pressed again (Only PLATFORM_DESKTOP)
public func isKeyPressedRepeat(_ key: Key) -> Bool { IsKeyPressedRepeat(Int32(key.rawValue)) }

/// Check if a key is being pressed
public func isKeyDown(_ key: Key) -> Bool { IsKeyDown(Int32(key.rawValue)) }

/// Check if a key has been released once
public func isKeyReleased(_ key: Key) -> Bool { IsKeyReleased(Int32(key.rawValue)) }

/// Check if a key is NOT being pressed
public func isKeyUp(_ key: Key) -> Bool { IsKeyUp(Int32(key.rawValue)) }

/// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty/
public func getKeyPressed() -> Key { Key(rawValue: Int(GetKeyPressed())) ?? Key.none }

/// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
public func getCharPressed() -> Key { Key(rawValue: Int(GetCharPressed())) ?? Key.none }

/// Set a custom key to exit program (default is ESC)
public func setExitKey(_ key: Key) { SetExitKey(Int32(key.rawValue)) }
