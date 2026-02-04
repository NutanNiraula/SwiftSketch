public enum Rect {
    public static func draw(_ rect: [Int]) {
        guard rect.count == 4 else {
            fatalError("Rect array expects exactly 4 values [x, y, w, h].")
        }
        draw(x: rect[0], y: rect[1], w: rect[2], h: rect[3])
    }
    
    public static func draw(x: Int, y: Int, w: Int, h: Int) {
        if let fillColor = DrawStyle.fillColor {
            DrawRectangle(Int32(x), Int32(y), Int32(w), Int32(h), fillColor)
        }
        if let strokeColor = DrawStyle.strokeColor {
            let weight = max(1.0, DrawStyle.strokeWeight)
            if weight <= 1.0 {
                DrawRectangleLines(Int32(x), Int32(y), Int32(w), Int32(h), strokeColor)
            } else {
                DrawRectangleLinesEx(
                    Rectangle(x: Float(x), y: Float(y), width: Float(w), height: Float(h)),
                    Float(weight),
                    strokeColor
                )
            }
        }
    }
    
    public static func draw(r: Rectangle) {
        if let fillColor = DrawStyle.fillColor {
            DrawRectangleRec(r, fillColor)
        }
        if let strokeColor = DrawStyle.strokeColor {
            let weight = max(1.0, DrawStyle.strokeWeight)
            if weight <= 1.0 {
                DrawRectangleLines(Int32(r.x), Int32(r.y), Int32(r.width), Int32(r.height), strokeColor)
            } else {
                DrawRectangleLinesEx(r, Float(weight), strokeColor)
            }
        }
    }
    
    public static func fill(x: Int, y: Int, w: Int, h: Int, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawRectangle(Int32(x), Int32(y), Int32(w), Int32(h), fillColor)
    }

    public static func fill(_ rect: [Int], color: Color? = nil) {
        guard rect.count == 4 else {
            fatalError("Rect array expects exactly 4 values [x, y, w, h].")
        }
        fill(x: rect[0], y: rect[1], w: rect[2], h: rect[3], color: color)
    }
    
    public static func fill(r: Rectangle, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawRectangleRec(r, fillColor)
    }
    
    public static func rec(r: Rectangle, color: Color? = nil) {
        fill(r: r, color: color)
    }
    
    public static func line(x: Int, y: Int, w: Int, h: Int, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        let weight = max(1.0, t ?? DrawStyle.strokeWeight)
        if weight <= 1.0 {
            DrawRectangleLines(Int32(x), Int32(y), Int32(w), Int32(h), strokeColor)
        } else {
            DrawRectangleLinesEx(
                Rectangle(x: Float(x), y: Float(y), width: Float(w), height: Float(h)),
                Float(weight),
                strokeColor
            )
        }
    }

    public static func line(_ rect: [Int], t: Double? = nil, color: Color? = nil) {
        guard rect.count == 4 else {
            fatalError("Rect array expects exactly 4 values [x, y, w, h].")
        }
        line(x: rect[0], y: rect[1], w: rect[2], h: rect[3], t: t, color: color)
    }
    
    public static func line(r: Rectangle, t: Double? = nil, color: Color? = nil) {
        guard let strokeColor = color ?? DrawStyle.strokeColor else { return }
        let weight = max(1.0, t ?? DrawStyle.strokeWeight)
        if weight <= 1.0 {
            DrawRectangleLines(Int32(r.x), Int32(r.y), Int32(r.width), Int32(r.height), strokeColor)
        } else {
            DrawRectangleLinesEx(r, Float(weight), strokeColor)
        }
    }
    
    public static func vector(xy: Vector2, wh: Vector2, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawRectangleV(xy, wh, fillColor)
    }
    
    public static func square(x: Int, y: Int, s: Int, color: Color? = nil) {
        fill(x: x, y: y, w: s, h: s, color: color)
    }
    
    public static func square(xy: Vector2, s: Double, color: Color? = nil) {
        guard let fillColor = color ?? DrawStyle.fillColor else { return }
        DrawRectangleV(xy, .square(s), fillColor)
    }
    
    public static func pro(r: Rectangle, origin: Vector2, rot: Double, color: Color) {
        DrawRectanglePro(r, origin, Float(rot), color)
    }
    
    public static func gradientV(x: Int, y: Int, w: Int, h: Int, color1: Color, color2: Color) {
        DrawRectangleGradientV(Int32(x), Int32(y), Int32(w), Int32(h), color1, color2)
    }
    
    public static func gradientH(x: Int, y: Int, w: Int, h: Int, color1: Color, color2: Color) {
        DrawRectangleGradientH(Int32(x), Int32(y), Int32(w), Int32(h), color1, color2)
    }
    
    public static func gradient(r: Rectangle, color1: Color, color2: Color, color3: Color, color4: Color) {
        DrawRectangleGradientEx(r, color1, color2, color3, color4)
    }
    
    public static func rounded(r: Rectangle, round: Double, seg: Int) {
        if let fillColor = DrawStyle.fillColor {
            DrawRectangleRounded(r, Float(round), Int32(seg), fillColor)
        }
        if let strokeColor = DrawStyle.strokeColor {
            DrawRectangleRoundedLines(
                r,
                Float(round),
                Int32(seg),
                strokeColor
            )
        }
    }
    
    public static func rounded(r: Rectangle, round: Double, seg: Int, color: Color) {
        DrawRectangleRounded(r, Float(round), Int32(seg), color)
    }
    
    public static func roundedLine(r: Rectangle, round: Double, seg: Int, color: Color) {
        DrawRectangleRoundedLines(r, Float(round), Int32(seg), color)
    }
}

//        void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle
//        void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters
//        void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a vertical-gradient-filled rectangle
//        void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a horizontal-gradient-filled rectangle
//        void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);       // Draw a gradient-filled rectangle with custom vertex colors
//        void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline
//        void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters
//        void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              // Draw rectangle with rounded edges
//        void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, float lineThick, Color color); // Draw rectangle with rounded edges outline
