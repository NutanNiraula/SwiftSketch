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
        timeValue = Render.timeSeconds()
        mousePos = Mouse.position()
        lastWheel = Mouse.wheelMove()
        
        var key = Key.pressed()
        while key != .none {
            lastKey = key
            key = Key.pressed()
        }
        
        var ch = Key.charPressed()
        while ch != .none {
            lastChar = ch
            ch = Key.charPressed()
        }
    }
    
    public func draw() {
        Render.background(.rayWhite)
        Render.stroke(.darkGray)
        Render.strokeWeight(2)
        Render.fill(.skyBlue)
        
        Rect.draw(x: 40, y: 40, w: 140, h: 80)
        Rect.rounded(r: Rectangle(x: 220, y: 40, width: 140, height: 80), round: 0.2, seg: 8)
        Rect.gradientH(x: 400, y: 40, w: 140, h: 80, color1: .orange, color2: .purple)
        
        Render.fill(.yellow)
        Circle.draw(x: 120, y: 180, r: 40)
        
        Render.fill(.green)
        Ellipse.draw(x: 260, y: 180, rx: 60, ry: 35)
        
        Render.fill(.pink)
        Ring.fill(xy: [460, 180], rIn: 20, rOut: 40, a0: 0, a1: 300, seg: 24, color: .pink)
        
        Render.noFill()
        Render.stroke(.blue)
        Circle.line(x: 600, y: 180, r: 40)
        Ellipse.line(x: 740, y: 180, rx: 50, ry: 30)
        
        Render.fill(.red)
        Triangle.draw(a: [80, 320], b: [150, 260], c: [220, 320])

        Render.fill(.lime)
        Quad.draw(a: [260, 260], b: [360, 250], c: [380, 330], d: [280, 340])
        
        Render.fill(.gold)
        Polygon.draw(xy: [500, 300], sides: 6, r: 45, rot: timeValue * 25)
        
        Render.stroke(.darkPurple)
        Render.strokeWeight(3)
        Line.draw(x1: 40, y1: 380, x2: 420, y2: 380)
        Line.draw(a: [420, 380], b: [520, 320])
        
        Render.strokeWeight(1)
        Render.fill(.white)
        Rect.draw(x: 40, y: 420, w: 460, h: 240)
        Render.stroke(.darkGray)
        Rect.line(x: 40, y: 420, w: 460, h: 240, color: .darkGray)
        
        Render.fill(.black)
        Text.draw("Input", xy: [60, 440], size: 20)
        Text.draw("Mouse: (\(Int(mousePos.x)), \(Int(mousePos.y)))", xy: [60, 470], size: 18)
        Text.draw(
            "Buttons: L \(Mouse.isButtonDown(.left))  M \(Mouse.isButtonDown(.middle))  R \(Mouse.isButtonDown(.right))",
            xy: [60, 495],
            size: 18
        )
        Text.draw("Wheel: \(String(format: "%.2f", lastWheel))", xy: [60, 520], size: 18)            
        Text.draw("Last Key: \(String(describing: lastKey))", xy: [60, 545], size: 18)
        Text.draw("Last Char: \(String(describing: lastChar))", xy: [60, 570], size: 18)
        
        Render.stroke(.red)
        Render.strokeWeight(2)
        Line.draw(a: [Double(mousePos.x - 12), Double(mousePos.y)], b: [Double(mousePos.x + 12), Double(mousePos.y)])
        Line.draw(a: [Double(mousePos.x), Double(mousePos.y - 12)], b: [Double(mousePos.x), Double(mousePos.y + 12)])
        
        Render.fill(.darkBlue)
        Text.draw("Hold mouse buttons or press keys to see updates", xy: [60, 610], size: 16)
    }
}
