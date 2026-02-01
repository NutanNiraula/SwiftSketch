import CRaylib

extension Color {
    public static let subtleGray     = Color(r: 200, g: 200, b: 200, a: 125)
    public static let lightGray     = Color(r: 200, g: 200, b: 200, a: 255)
    public static let gray          = Color(r: 150, g: 150, b: 150, a: 255)
    public static let darkGray      = Color(r: 80, g: 80, b: 80, a: 255)
    public static let yellow        = Color(r: 253, g: 249, b: 0, a: 255)
    public static let gold          = Color(r: 255, g: 203, b: 0, a: 255)
    public static let orange        = Color(r: 255, g: 161, b: 0, a: 255)
    public static let pink          = Color(r: 255, g: 109, b: 194, a: 255)
    public static let red           = Color(r: 230, g: 41, b: 55, a: 255)
    public static let maroon        = Color(r: 190, g: 33, b: 55, a: 255)
    public static let green         = Color(r: 0, g: 228, b: 48, a: 255)
    public static let lime          = Color(r: 0, g: 158, b: 47, a: 255)
    public static let darkGreen     = Color(r: 0, g: 117, b: 44, a: 255)
    public static let skyBlue       = Color(r: 102, g: 191, b: 255, a: 255)
    public static let blue          = Color(r: 0, g: 121, b: 241, a: 255)
    public static let darkBlue      = Color(r: 0, g: 82, b: 172, a: 255)
    public static let purple        = Color(r: 200, g: 122, b: 255, a: 255)
    public static let violet        = Color(r: 135, g: 60, b: 190, a: 255)
    public static let darkPurple    = Color(r: 112, g: 31, b: 126, a: 255)
    public static let beige         = Color(r: 211, g: 176, b: 131, a: 255)
    public static let brown         = Color(r: 127, g: 106, b: 79, a: 255)
    public static let darkBrown     = Color(r: 76, g: 63, b: 47, a: 255)
    
    public static let white         = Color(r: 255, g: 255, b: 255, a: 255)
    public static let black         = Color(r: 0, g: 0, b: 0, a: 255)
    public static let blank         = Color(r: 0, g: 0, b: 0, a: 0)
    public static let magenta       = Color(r: 255, g: 0, b: 255, a: 255)
    public static let rayWhite      = Color(r: 245, g: 245, b: 245, a: 255)
    
    public func withOpacity(_ opacity: UInt8) -> Color {
        var color = self
        color.a = opacity
        return color
    }
    
    public func lerp(to: Color, _ amount: Double) -> Color {
        Color(
            r: UInt8(Lerp(Float(self.r), Float(to.r), Float(amount))),
            g: UInt8(Lerp(Float(self.g), Float(to.g), Float(amount))),
            b: UInt8(Lerp(Float(self.b), Float(to.b), Float(amount))),
            a: UInt8(Lerp(Float(self.a), Float(to.a), Float(amount)))
        )
    }
}
