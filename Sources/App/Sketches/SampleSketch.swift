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
        clearBackground(.rayWhite)
        
        // 2. Draw shapes (using high-level wrappers)
        rect(Int(xPos), 360, 50, 50, color: .orange)
        text("Hello Swift!", 100, 20, fontSize: 24, color: .gray)
        
        // 3. Draw UI (Immediate Mode)
        if ImGuiUI.begin("Controls") {
            ImGuiUI.text("Position: \(xPos)")
            // Add more controls here...
        }
        ImGuiUI.end()
    }
}
