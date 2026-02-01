
public func rect(_ x: Int,_ y: Int,_ width: Int,_ height: Int, color: Color) {
    DrawRectangle(Int32(x), Int32(y), Int32(width), Int32(height), color)
}

public func rectLines(_ x: Int,_ y: Int,_ width: Int,_ height: Int, color: Color) {
    DrawRectangleLines(Int32(x), Int32(y), Int32(width), Int32(height), color)
}

public func square(_ x: Int,_ y: Int,_ width: Int, color: Color) {
    DrawRectangle(Int32(x), Int32(y), Int32(width), Int32(width), color)
}

public func rectV(_ position: Vector2,_ size: Vector2, color: Color) {
    DrawRectangleV(position, size, color)
}

public func squareV(_ position: Vector2,_ width: Double, color: Color) {
    DrawRectangleV(position, .square(width), color)
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
