import SwiftSketchCore

public final class SampleSketch: Sketch {
    var xPos: Double = 0
    var speed: Double = 2.0
    
    public init() {}
    
    // Called once at startup
    public func setup() {
        // Initialize the window with size and title
        App.initWindow(w: 960, h: 720, title: "Creative Coding in Swift")
        App.fps(true) // Show FPS counter
        
        // Enable ImGui for debug UI (Optional)
        App.enableImGui(theme: .light)
    }
    
    // Called every frame to update state
    public func update() {
        xPos += speed
        if xPos > Double(App.screenWidth) {
            xPos = 0
        }
    }
    
    // Called every frame to render
    public func draw() {
        // 1. Clear the background
        Render.clearBackground(.rayWhite)
        
        // 2. Draw shapes (using high-level wrappers)
        Rect.fill([Int(xPos), 360, 50, 50], color: .orange)
        Text.draw("Hello SwiftSketch!", xy: [100, 20], size: 24, color: .gray)
        
        // 3. Draw UI (Immediate Mode)
        ImWindow("Controls").render {
            ImText("Position: \(xPos)")
        }
    }
}
