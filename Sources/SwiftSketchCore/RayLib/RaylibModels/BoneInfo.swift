import CRaylib

public extension BoneInfo {
    init(name: String, parent: Int) {
        self.init()
        self.name = emptyBoneNameBuffer()
        writeBoneName(name, into: &self.name)
        self.parent = Int32(parent)
    }
    
    var parentIndex: Int {
        Int(parent)
    }
}

private func emptyBoneNameBuffer() -> (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8) {
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
}

private func writeBoneName(_ value: String, into buffer: inout (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8)) {
    let bytes = Array(value.utf8.prefix(31))
    withUnsafeMutableBytes(of: &buffer) { raw in
        for i in 0..<raw.count { raw[i] = 0 }
        for (i, b) in bytes.enumerated() { raw[i] = b }
    }
}
