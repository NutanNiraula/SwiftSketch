import SwiftSketchCore

public final class ApiShowcase: Sketch {
    private var lastKey: Key = .none
    private var lastChar: Key = .none
    private var lastWheel: Double = 0
    private var mousePos: Vector2 = .zero
    private var timeValue: Double = 0
    
    public init() {}
    
    public func setup() {
        App.initWindow(w: 1024, h: 720, title: "SwiftSketch API Showcase")
        App.fps(true)
    }
    
    public func update() {
        timeValue = timeSeconds()
        mousePos = getMousePosition()
        lastWheel = getMouseWheelMove()
        
        var key = getKeyPressed()
        while key != .none {
            lastKey = key
            key = getKeyPressed()
        }
        
        var ch = getCharPressed()
        while ch != .none {
            lastChar = ch
            ch = getCharPressed()
        }
    }
    
    public func draw() {
        background(.rayWhite)
        stroke(.darkGray)
        strokeWeight(2)
        fill(.skyBlue)
        
        Rect.draw(x: 40, y: 40, w: 140, h: 80)
        Rect.rounded(r: Rectangle(x: 220, y: 40, width: 140, height: 80), round: 0.2, seg: 8)
        Rect.gradientH(x: 400, y: 40, w: 140, h: 80, color1: .orange, color2: .purple)
        
        fill(.yellow)
        Circle.draw(x: 120, y: 180, r: 40)
        
        fill(.green)
        Ellipse.draw(x: 260, y: 180, rx: 60, ry: 35)
        
        fill(.pink)
        Ring.fill(xy: [460, 180], rIn: 20, rOut: 40, a0: 0, a1: 300, seg: 24, color: .pink)
        
        noFill()
        stroke(.blue)
        Circle.line(x: 600, y: 180, r: 40)
        Ellipse.line(x: 740, y: 180, rx: 50, ry: 30)
        
        fill(.red)
        Triangle.draw(a: [80, 320], b: [150, 260], c: [220, 320])

        fill(.lime)
        Quad.draw(a: [260, 260], b: [360, 250], c: [380, 330], d: [280, 340])
        
        fill(.gold)
        Polygon.draw(xy: [500, 300], sides: 6, r: 45, rot: timeValue * 25)
        
        stroke(.darkPurple)
        strokeWeight(3)
        Line.draw(x1: 40, y1: 380, x2: 420, y2: 380)
        Line.draw(a: [420, 380], b: [520, 320])
        
        strokeWeight(1)
        fill(.white)
        Rect.draw(x: 40, y: 420, w: 460, h: 240)
        stroke(.darkGray)
        Rect.line(x: 40, y: 420, w: 460, h: 240, color: .darkGray)
        
        fill(.black)
        Text.draw("Input", xy: [60, 440], size: 20)
        Text.draw("Mouse: (\(Int(mousePos.x)), \(Int(mousePos.y)))", xy: [60, 470], size: 18)
        Text.draw(
            "Buttons: L \(isMouseButtonDown(.left))  M \(isMouseButtonDown(.middle))  R \(isMouseButtonDown(.right))",
            xy: [60, 495],
            size: 18
        )
        Text.draw("Wheel: \(String(format: "%.2f", lastWheel))", xy: [60, 520], size: 18)            
        Text.draw("Last Key: \(String(describing: lastKey))", xy: [60, 545], size: 18)
        Text.draw("Last Char: \(String(describing: lastChar))", xy: [60, 570], size: 18)
        
        stroke(.red)
        strokeWeight(2)
        Line.draw(a: [Double(mousePos.x - 12), Double(mousePos.y)], b: [Double(mousePos.x + 12), Double(mousePos.y)])
        Line.draw(a: [Double(mousePos.x), Double(mousePos.y - 12)], b: [Double(mousePos.x), Double(mousePos.y + 12)])
        
        fill(.darkBlue)
        Text.draw("Hold mouse buttons or press keys to see updates", xy: [60, 610], size: 16)
    }
}
