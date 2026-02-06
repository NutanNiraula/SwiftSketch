import CRaylib

public extension Music {
    init(stream: AudioStream, frameCount: Int, looping: Bool, ctxType: Int, ctxData: UnsafeMutableRawPointer?) {
        self.init()
        self.stream = stream
        self.frameCount = UInt32(frameCount)
        self.looping = looping
        self.ctxType = Int32(ctxType)
        self.ctxData = ctxData
    }
    
    var duration: Double {
        guard stream.sampleRate > 0, stream.channels > 0 else { return 0 }
        return Double(frameCount) / Double(stream.sampleRate * stream.channels)
    }
}
