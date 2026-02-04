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
            Rect.fill(x: x, y: y, w: 30, h: 30, color: rectColor)
        }
        
        // UI Overlay
        Rect.fill(x: 16, y: 42, w: 220, h: 60, color: .white)
        Text.draw(message, x: 20, y: 50, size: 18, color: .black)
        Text.draw("Count: \(count)", x: 20, y: 70, size: 18, color: .gray)
        Text.draw("FPS: \(GetFPS())", x: 20, y: 90, size: 18, color: .gray)
    }
}
