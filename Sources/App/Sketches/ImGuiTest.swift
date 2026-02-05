import Foundation
import SwiftSketchCore

public final class ImGuiTest: Sketch {
    public var frameCount: Int = 0
    public var message = "This is first example"
    private var clickCount = 0
    private var showPlot2D = true
    private var showPlot3D = true
    private var sliderValue = 0.5
    private var sliderIntValue = 25
    private var inputIntValue = 10
    private var inputBuffer: [CChar] = ImGuiTest.makeTextBuffer("SwiftSketch", capacity: 64)
    private var comboIndex = 0
    private let comboItems = ["Sine", "Cosine", "Wave"]
    private var progressValue = 0.0
    private var colorRGB: [Double] = [0.2, 0.6, 0.9]
    private var colorRGBA: [Double] = [0.9, 0.2, 0.2, 1.0]
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
        progressValue = (sin(Double(frameCount) * 0.05) + 1) * 0.5
    }

    public func draw() {
        ImWindow("ImGui Components", options: [.alwaysAutoResize]).render {
            VStack {
                ImText("Frame: \(frameCount)")
                Divider()
                ImText(message)
                CheckBox("Show 2D Plot", isOn: { self.showPlot2D }, set: { self.showPlot2D = $0 })
                CheckBox("Show 3D Plot", isOn: { self.showPlot3D }, set: { self.showPlot3D = $0 })
                SliderFloat("Float Slider", value: { self.sliderValue }, set: { self.sliderValue = $0 }, min: 0, max: 1)
                SliderInt("Int Slider", value: { self.sliderIntValue }, set: { self.sliderIntValue = $0 }, min: 0, max: 100)
                InputInt("Input Int", value: { self.inputIntValue }, set: { self.inputIntValue = $0 })
                InputText("Input Text", buffer: { self.inputBuffer }, set: { self.inputBuffer = $0 })
                Combo("Wave Type", items: self.comboItems, selection: { self.comboIndex }, set: { self.comboIndex = $0 })
                ProgressBar({ self.progressValue }, overlay: { "\(Int(self.progressValue * 100))%" })
                ColorEdit3("RGB", values: { self.colorRGB }, set: { self.colorRGB = $0 })
                ColorEdit4("RGBA", values: { self.colorRGBA }, set: { self.colorRGBA = $0 })
                ImText("Typed: \(String(cString: self.inputBuffer))")
                if self.comboItems.indices.contains(self.comboIndex) {
                    ImText("Selected: \(self.comboItems[self.comboIndex])")
                }
                HStack {
                    Button("Add") { self.clickCount += 1 }
                    Button("Reset") { self.clickCount = 0 }
                }
                ImText("Clicks: \(clickCount)")
            }
        }

        ImWindow("ImGui Plots", options: [.alwaysAutoResize]).render {
            VStack {
                if self.showPlot2D {
                    ImPlot2D(
                        "Sine Wave",
                        w: 320,
                        h: 180,
                        axis: .init(x: "x", y: "sin(x)")
                    ) {
                        plotLine("sin", values: self.plotSamples, xScale: self.plotXScale, yScale: 1.0)
                    }
                }
                if self.showPlot3D {
                    ImPlot3D(
                        "Helix 3D",
                        w: 320,
                        h: 240,
                        axis: .init(x: "x", y: "y", z: "z")
                    ) {
                        plotLine("helix", xs: self.plot3DX, ys: self.plot3DY, zs: self.plot3DZ)
                    }
                }
            }
        }
        
        // Raylib Version Display
        let vText = "Raylib \(App.raylibVersion)"
        let boxX = 20
        let boxY = 660
        let boxW = 160
        let boxH = 40
        
        Rect.line(x: boxX, y: boxY, w: boxW, h: boxH, color: .red)
        Text.draw(vText, x: boxX + 10, y: boxY + 10, size: 20, color: .red)
    }

    private static func makeTextBuffer(_ text: String, capacity: Int) -> [CChar] {
        let size = max(capacity, 1)
        var buffer = Array(repeating: CChar(0), count: size)
        let utf8 = Array(text.utf8CString)
        let count = min(utf8.count, size)
        if count > 0 {
            buffer.replaceSubrange(0..<count, with: utf8.prefix(count))
        }
        buffer[size - 1] = 0
        return buffer
    }
}
