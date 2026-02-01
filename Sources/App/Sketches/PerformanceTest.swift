import Foundation
import SwiftSketchCore

public final class PerformanceTest: Sketch {
    public var frameCount: Int = 0
    public var message = "High-Level API Stress Test"
    
    // Testing limits of high-level API
    private let count = 100_000
    
    // Fast RNG state (Xorshift)
    private var rngState: UInt64 = 123456789
    
    // Cached values
    private var w: Int = 960
    private var h: Int = 640
    private let rectColor = Color(r: 0, g: 255, b: 0, a: 1)

    public init() {}

    public func setup() {
        App.initWindow(w: w, h: h)
        App.fps(true)
        SetTargetFPS(0) // Unlock FPS
        
        w = Int(App.screenWidth)
        h = Int(App.screenHeight)
    }

    public func update() {
        frameCount += 1
    }

    public func draw() {
        // High-level API loop
        // Still using fast RNG to ensure bottleneck is rendering/interop, not math
        
        for _ in 0..<count {
            // Fast Xorshift RNG
            rngState ^= rngState << 13
            rngState ^= rngState >> 7
            rngState ^= rngState << 17
            
            // Map to screen coordinates
            let x = Int(rngState & 0xFFFF) % w
            let y = Int((rngState >> 16) & 0xFFFF) % h
            
            // Standard high-level API call
            rect(x, y, 30, 30, color: rectColor)
        }
        
        // UI Overlay
        rect(16, 42, 220, 60, color: .white)
        text(message, 20, 50, fontSize: 18, color: .black)
        text("Count: \(count)", 20, 70, fontSize: 18, color: .gray)
        text("FPS: \(GetFPS())", 20, 90, fontSize: 18, color: .gray)
    }
}
