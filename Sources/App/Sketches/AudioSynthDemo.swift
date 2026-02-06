import Foundation
import SwiftSketchCore

public final class AudioSynthDemo: Sketch {
    private let sampleRate = 44100
    private let channels = 2
    private let framesPerBuffer = 512
    private var stream: AudioStream?
    private var phase: Double = 0
    private var frequency: Double = 220
    private var amplitude: Double = 0.2
    
    public init() {}
    
    deinit {
        if let stream {
            Audio.stopAudioStream(stream)
            Audio.unloadAudioStream(stream)
        }
        Audio.closeDevice()
    }
    
    public func setup() {
        App.initWindow(w: 960, h: 540, title: "Audio Synth Demo", targetFPS: 60, bgColor: .rayWhite)
        App.fps(true)
        Audio.initDevice()
        let stream = Audio.loadAudioStream(sampleRate: sampleRate, sampleSize: 32, channels: channels)
        self.stream = stream
        Audio.playAudioStream(stream)
    }
    
    public func update() {
        let w = max(1.0, Double(App.screenWidth))
        let h = max(1.0, Double(App.screenHeight))
        let nx = min(1.0, max(0.0, Double(Mouse.x()) / w))
        let ny = min(1.0, max(0.0, Double(Mouse.y()) / h))
        frequency = 110.0 + nx * 880.0
        amplitude = 0.05 + (1.0 - ny) * 0.3
        
        guard let stream else { return }
        guard Audio.isAudioStreamProcessed(stream) else { return }
        
        var samples = [Float](repeating: 0, count: framesPerBuffer * channels)
        let useSquare = Mouse.isButtonDown(.left)
        for i in 0..<framesPerBuffer {
            let phaseValue = phase * 2.0 * Double.pi
            let sampleValue: Double
            if useSquare {
                sampleValue = (sin(phaseValue) >= 0 ? 1.0 : -1.0) * amplitude
            } else {
                sampleValue = sin(phaseValue) * amplitude
            }
            let value = Float(sampleValue)
            let index = i * channels
            samples[index] = value
            samples[index + 1] = value
            phase += frequency / Double(sampleRate)
            if phase >= 1.0 {
                phase -= 1.0
            }
        }
        
        samples.withUnsafeBytes { buffer in
            guard let base = buffer.baseAddress else { return }
            Audio.updateAudioStream(stream, data: base, frameCount: framesPerBuffer)
        }
    }
    
    public func draw() {
        Text.draw("Audio Synth Demo", x: 20, y: 20, size: 24, color: .black)
        Text.draw("Mouse X: pitch", x: 20, y: 52, size: 18, color: .darkGray)
        Text.draw("Mouse Y: volume", x: 20, y: 74, size: 18, color: .darkGray)
        Text.draw("Hold left mouse: square wave", x: 20, y: 96, size: 18, color: .darkGray)
        Text.draw(String(format: "Freq: %.1f Hz", frequency), x: 20, y: 128, size: 18, color: .gray)
        Text.draw(String(format: "Amp: %.2f", amplitude), x: 20, y: 150, size: 18, color: .gray)
    }
}
