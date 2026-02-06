import CRaylib

public extension Sound {
    init(stream: AudioStream, frameCount: Int) {
        self.init()
        self.stream = stream
        self.frameCount = UInt32(frameCount)
    }
    
    var duration: Double {
        guard stream.sampleRate > 0, stream.channels > 0 else { return 0 }
        return Double(frameCount) / Double(stream.sampleRate * stream.channels)
    }
}
