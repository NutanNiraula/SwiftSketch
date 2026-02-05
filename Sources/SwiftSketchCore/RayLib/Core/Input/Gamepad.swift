public enum GamepadButton: Int {
    case unknown = 0
    case leftFaceUp = 1
    case leftFaceRight = 2
    case leftFaceDown = 3
    case leftFaceLeft = 4
    case rightFaceUp = 5
    case rightFaceRight = 6
    case rightFaceDown = 7
    case rightFaceLeft = 8
    case leftTrigger1 = 9
    case leftTrigger2 = 10
    case rightTrigger1 = 11
    case rightTrigger2 = 12
    case middleLeft = 13
    case middle = 14
    case middleRight = 15
    case leftThumb = 16
    case rightThumb = 17
}

public enum GamepadAxis: Int {
    case leftX = 0
    case leftY = 1
    case rightX = 2
    case rightY = 3
    case leftTrigger = 4
    case rightTrigger = 5
}

public enum Gamepad {
    public static func isAvailable(_ id: Int) -> Bool {
        IsGamepadAvailable(Int32(id))
    }

    public static func name(_ id: Int) -> String {
        guard let cString = GetGamepadName(Int32(id)) else { return "" }
        return String(cString: cString)
    }

    public static func isButtonPressed(_ id: Int, _ button: GamepadButton) -> Bool {
        IsGamepadButtonPressed(Int32(id), Int32(button.rawValue))
    }

    public static func isButtonDown(_ id: Int, _ button: GamepadButton) -> Bool {
        IsGamepadButtonDown(Int32(id), Int32(button.rawValue))
    }

    public static func isButtonReleased(_ id: Int, _ button: GamepadButton) -> Bool {
        IsGamepadButtonReleased(Int32(id), Int32(button.rawValue))
    }

    public static func isButtonUp(_ id: Int, _ button: GamepadButton) -> Bool {
        IsGamepadButtonUp(Int32(id), Int32(button.rawValue))
    }

    public static func buttonPressed() -> GamepadButton {
        GamepadButton(rawValue: Int(GetGamepadButtonPressed())) ?? .unknown
    }

    public static func axisCount(_ id: Int) -> Int {
        Int(GetGamepadAxisCount(Int32(id)))
    }

    public static func axisMovement(_ id: Int, _ axis: GamepadAxis) -> Double {
        Double(GetGamepadAxisMovement(Int32(id), Int32(axis.rawValue)))
    }

    public static func setMappings(_ mappings: String) -> Int {
        mappings.withCString { Int(SetGamepadMappings($0)) }
    }

    public static func setVibration(_ id: Int, leftMotor: Double, rightMotor: Double, duration: Double) {
        SetGamepadVibration(Int32(id), Float(leftMotor), Float(rightMotor), Float(duration))
    }
}
