import CRaylib

public extension ModelAnimation {
    init(
        boneCount: Int,
        frameCount: Int,
        bones: UnsafeMutablePointer<BoneInfo>?,
        framePoses: UnsafeMutablePointer<UnsafeMutablePointer<Transform>?>?,
        name: String = ""
    ) {
        self.init()
        _ = bones
        self.boneCount = Int32(boneCount)
        self.keyframeCount = Int32(frameCount)
        self.keyframePoses = framePoses
        self.name = makeNameBuffer(name)
    }
    
    var hasFrames: Bool {
        keyframeCount > 0
    }
}

private func emptyNameBuffer() -> (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8) {
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
}

private func writeName(_ value: String, into buffer: inout (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8)) {
    let bytes = Array(value.utf8.prefix(31))
    withUnsafeMutableBytes(of: &buffer) { raw in
        for i in 0..<raw.count { raw[i] = 0 }
        for (i, b) in bytes.enumerated() { raw[i] = b }
    }
}

private func makeNameBuffer(_ value: String) -> (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8) {
    var buffer = emptyNameBuffer()
    writeName(value, into: &buffer)
    return buffer
}
