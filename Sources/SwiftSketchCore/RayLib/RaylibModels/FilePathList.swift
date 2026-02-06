import CRaylib

public extension FilePathList {
    init(count: Int, paths: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?) {
        self.init()
        self.count = UInt32(count)
        self.paths = paths
    }
    
    func strings() -> [String] {
        guard let paths else { return [] }
        var result: [String] = []
        result.reserveCapacity(Int(count))
        for i in 0..<Int(count) {
            if let cString = paths[i] {
                result.append(String(cString: cString))
            }
        }
        return result
    }
}
