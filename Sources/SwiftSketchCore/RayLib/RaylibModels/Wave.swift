import CRaylib

public extension Wave {
    init(frameCount: Int, sampleRate: Int, sampleSize: Int, channels: Int, data: UnsafeMutableRawPointer?) {
        self.init()
        self.frameCount = UInt32(frameCount)
        self.sampleRate = UInt32(sampleRate)
        self.sampleSize = UInt32(sampleSize)
        self.channels = UInt32(channels)
        self.data = data
    }
    
    var duration: Double {
        guard sampleRate > 0, channels > 0 else { return 0 }
        return Double(frameCount) / Double(sampleRate * channels)
    }
}
