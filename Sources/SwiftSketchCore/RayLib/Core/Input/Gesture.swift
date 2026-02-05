public enum Gesture {
    public struct Flag: OptionSet {
        public let rawValue: Int32
        
        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }
        
        public static let none: Flag = []
        public static let tap = Flag(rawValue: 1)
        public static let doubleTap = Flag(rawValue: 2)
        public static let hold = Flag(rawValue: 4)
        public static let drag = Flag(rawValue: 8)
        public static let swipeRight = Flag(rawValue: 16)
        public static let swipeLeft = Flag(rawValue: 32)
        public static let swipeUp = Flag(rawValue: 64)
        public static let swipeDown = Flag(rawValue: 128)
        public static let pinchIn = Flag(rawValue: 256)
        public static let pinchOut = Flag(rawValue: 512)
    }
    
    public static func setEnabled(_ flags: Flag) {
        SetGesturesEnabled(UInt32(bitPattern: flags.rawValue))
    }
    
    public static func isDetected(_ flags: Flag) -> Bool {
        IsGestureDetected(UInt32(bitPattern: flags.rawValue))
    }
    
    public static func detected() -> Flag {
        Flag(rawValue: GetGestureDetected())
    }
    
    public static func holdDuration() -> Double {
        Double(GetGestureHoldDuration())
    }
    
    public static func dragVector() -> Vector2 {
        GetGestureDragVector()
    }
    
    public static func dragAngle() -> Double {
        Double(GetGestureDragAngle())
    }
    
    public static func pinchVector() -> Vector2 {
        GetGesturePinchVector()
    }
    
    public static func pinchAngle() -> Double {
        Double(GetGesturePinchAngle())
    }
}
