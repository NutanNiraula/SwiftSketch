import CRaylib

public extension AudioStream {
    init(sampleRate: Int, sampleSize: Int, channels: Int) {
        self.init()
        self.buffer = nil
        self.processor = nil
        self.sampleRate = UInt32(sampleRate)
        self.sampleSize = UInt32(sampleSize)
        self.channels = UInt32(channels)
    }
    
    var isValid: Bool {
        buffer != nil && sampleRate > 0
    }
}
