import Foundation
import SwiftSketchCore

public final class AnimShowcaseSketch: Sketch {
    private var timeline: Anim.Timeline2D!
    
    public init() {}
    
    public func setup() {
        App.initWindow(w: 1200, h: 720, title: "Animation DSL Showcase")
        App.fps(true)
        
        let center = Vector2(Double(App.screenWidth) * 0.5, Double(App.screenHeight) * 0.5)
        
        let polyCenter = Vector2(Double(App.screenWidth) * 0.75, Double(App.screenHeight) * 0.5)
        let circlePoly = Anim.Path2D.circle(center: polyCenter, radius: 120)
        let rectanglePoly = Anim.Path2D.rectangle(center: polyCenter, width: 220, height: 120)
        let starPoly = Anim.Path2D.star(center: polyCenter, radius: 120, inner: 50, points: 5)
        let trianglePoly = Anim.Path2D.polygon(center: polyCenter, radius: 120, sides: 3)
        
        let morphNode = Anim.path(circlePoly, closed: true)
            .base(pos: .zero, color: .red)
            .morph(0.0, to: trianglePoly, .easeInOut)
            .morphVia(3.3, to: rectanglePoly, via: circlePoly, .easeOut)
            .morphVia(6.6, to: starPoly, via: circlePoly, .easeOut)
            .morphVia(10.0, to: trianglePoly, via: circlePoly, .easeOut)
        
        let rect = Rectangle(x: 0, y: 0, width: 160, height: 100)
        let rectNode = Anim.rect(rect, origin: [80, 50])
            .base(pos: [260, 180], scale: .square(1.0), rot: 0, color: .blue)
            .move(0.0, to: Vector2(260.0, 180.0), .easeInOut)
            .move(2.5, to: Vector2(260.0, 520.0), .easeInOut)
            .move(5.0, to: Vector2(260.0, 180.0), .easeInOut)
            .move(7.5, to: Vector2(260.0, 520.0), .easeInOut)
            .move(10.0, to: Vector2(260.0, 180.0), .easeInOut)
            .scale(0.0, to: .square(1.0))
            .scale(2.5, to: .square(1.8), .easeInOut)
            .scale(5.0, to: .square(1.0), .easeInOut)
            .scale(7.5, to: .square(1.8), .easeInOut)
            .scale(10.0, to: .square(1.0), .easeInOut)
            .rotate(0.0, to: 0.0)
            .rotate(5.0, to: 360.0, .linear)
            .rotate(10.0, to: 720.0, .linear)
            .tint(0.0, to: .blue)
            .tint(3.3, to: .red, .easeInOut)
            .tint(6.6, to: .green, .easeInOut)
            .tint(10.0, to: .blue, .easeInOut)
        
        let orbitCenter = center
        let orbitRadius = 140.0
        let orbitSteps = 12
        var orbitNode = Anim.circle(center: [0, 0], radius: 18)
            .base(pos: .zero, scale: .square(1.0), rot: 0, color: .orange)
            .tint(0.0, to: .orange)
            .tint(5.0, to: .magenta, .easeIn)
            .tint(10.0, to: .orange, .easeOut)
            
        for i in 0...orbitSteps {
            let u = Double(i) / Double(orbitSteps)
            let a = u * 2.0 * Double.pi
            let p = Vector2(
                Double(orbitCenter.x) + cos(a) * orbitRadius,
                Double(orbitCenter.y) + sin(a) * orbitRadius
            )
            orbitNode = orbitNode.move(u * 10.0, to: p, .linear)
        }
        
        timeline = Anim.timeline(duration: 10.0, loop: true) {
            rectNode
            morphNode
            orbitNode
        }
    }
    
    public func update() {
        timeline.update(delta: Double(GetFrameTime()))
    }
    
    public func draw() {
        Render.clearBackground(.rayWhite)
        timeline.draw()
        
        Text.draw("Animation DSL Showcase", x: 16, y: 16, size: 24, color: .black)
        Text.draw("Moves + Scale + Rotate + Color + Morph", x: 16, y: 44, size: 18, color: .gray)
    }
}

