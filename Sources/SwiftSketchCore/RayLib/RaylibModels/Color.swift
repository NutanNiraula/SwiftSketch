import CRaylib

public extension Color {
    init(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1.0) {
        let red = UInt8(max(0.0, min(1.0, r)) * 255.0)
        let green = UInt8(max(0.0, min(1.0, g)) * 255.0)
        let blue = UInt8(max(0.0, min(1.0, b)) * 255.0)
        let alpha = UInt8(max(0.0, min(1.0, a)) * 255.0)
        self.init(r: red, g: green, b: blue, a: alpha)
    }
    
    func withAlpha(_ alpha: Double) -> Color {
        Color(Double(r) / 255.0, Double(g) / 255.0, Double(b) / 255.0, alpha)
    }

    static let subtleGray    = Color(r: 200, g: 200, b: 200, a: 125)
    static let lightGray     = Color(r: 200, g: 200, b: 200, a: 255)
    static let gray          = Color(r: 150, g: 150, b: 150, a: 255)
    static let darkGray      = Color(r: 80, g: 80, b: 80, a: 255)
    static let yellow        = Color(r: 253, g: 249, b: 0, a: 255)
    static let gold          = Color(r: 255, g: 203, b: 0, a: 255)
    static let orange        = Color(r: 255, g: 161, b: 0, a: 255)
    static let pink          = Color(r: 255, g: 109, b: 194, a: 255)
    static let red           = Color(r: 230, g: 41, b: 55, a: 255)
    static let maroon        = Color(r: 190, g: 33, b: 55, a: 255)
    static let green         = Color(r: 0, g: 228, b: 48, a: 255)
    static let lime          = Color(r: 0, g: 158, b: 47, a: 255)
    static let darkGreen     = Color(r: 0, g: 117, b: 44, a: 255)
    static let skyBlue       = Color(r: 102, g: 191, b: 255, a: 255)
    static let blue          = Color(r: 0, g: 121, b: 241, a: 255)
    static let darkBlue      = Color(r: 0, g: 82, b: 172, a: 255)
    static let purple        = Color(r: 200, g: 122, b: 255, a: 255)
    static let violet        = Color(r: 135, g: 60, b: 190, a: 255)
    static let darkPurple    = Color(r: 112, g: 31, b: 126, a: 255)
    static let beige         = Color(r: 211, g: 176, b: 131, a: 255)
    static let brown         = Color(r: 127, g: 106, b: 79, a: 255)
    static let darkBrown     = Color(r: 76, g: 63, b: 47, a: 255)
    
    static let white         = Color(r: 255, g: 255, b: 255, a: 255)
    static let black         = Color(r: 0, g: 0, b: 0, a: 255)
    static let blank         = Color(r: 0, g: 0, b: 0, a: 0)
    static let magenta       = Color(r: 255, g: 0, b: 255, a: 255)
    static let rayWhite      = Color(r: 245, g: 245, b: 245, a: 255)
    
    func withOpacity(_ opacity: UInt8) -> Color {
        var color = self
        color.a = opacity
        return color
    }
    
    func lerp(to: Color, _ amount: Double) -> Color {
        Color(
            r: UInt8(Lerp(Float(self.r), Float(to.r), Float(amount))),
            g: UInt8(Lerp(Float(self.g), Float(to.g), Float(amount))),
            b: UInt8(Lerp(Float(self.b), Float(to.b), Float(amount))),
            a: UInt8(Lerp(Float(self.a), Float(to.a), Float(amount)))
        )
    }
}

