import Foundation
import SwiftSketchCore

public final class ImGuiTest: Sketch {
    public var frameCount: Int = 0
    public var message = "This is first example"
    private var plotSamples: [Double] = []
    private var plotXScale: Double = 1
    private var plot3DX: [Double] = []
    private var plot3DY: [Double] = []
    private var plot3DZ: [Double] = []

    public init() {}

    public func setup() {
        App.initWindow(w: 960, h: 720)
        App.fps(true)
        App.enableImGui(theme: .light)
        let sampleCount = 256
        plotSamples = (0..<sampleCount).map { index in
            let x = Double(index) * plotXScale
            return sin(x)
        }
        let sampleCount3D = 256
        plot3DX = []
        plot3DY = []
        plot3DZ = []
        plot3DX.reserveCapacity(sampleCount3D)
        plot3DY.reserveCapacity(sampleCount3D)
        plot3DZ.reserveCapacity(sampleCount3D)
        for index in 0..<sampleCount3D {
            let t = (Double(index) / Double(sampleCount3D - 1)) * (Double.pi * 4)
            plot3DX.append(cos(t))
            plot3DY.append(sin(t))
            plot3DZ.append((Double(index) / Double(sampleCount3D - 1)) * 2.0 - 1.0)
        }
    }

    public func update() {
        frameCount += 1
    }

    public func draw() {
        if ImGuiUI.begin("Swift ImGui", options: [.alwaysAutoResize]) {
            ImGuiUI.text("Frame: \(frameCount)")
            ImGuiUI.separator()
            ImGuiUI.text(message)
            if ImPlotUI.begin("Sine Wave", width: 320, height: 180) {
                ImPlotUI.setupAxes("x", "sin(x)")
                ImPlotUI.plotLine("sin", values: plotSamples, xScale: plotXScale)
                ImPlotUI.end()
            }
            if ImPlot3DUI.begin("Helix 3D", width: 320, height: 240) {
                ImPlot3DUI.setupAxes("x", "y", "z")
                ImPlot3DUI.plotLine("helix", xs: plot3DX, ys: plot3DY, zs: plot3DZ)
                ImPlot3DUI.end()
            }
        }
        ImGuiUI.end()
        
        // Raylib Version Display
        let vText = "Raylib \(App.raylibVersion)"
        let boxX = 20
        let boxY = 660
        let boxW = 160
        let boxH = 40
        
        rectLines(boxX, boxY, boxW, boxH, color: .red)
        text(vText, boxX + 10, boxY + 10, fontSize: 20, color: .red)
    }
}
