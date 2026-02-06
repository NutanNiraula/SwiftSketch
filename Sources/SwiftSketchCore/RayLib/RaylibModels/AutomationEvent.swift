import CRaylib

public extension AutomationEvent {
    init(frame: Int, type: Int, params: (Int, Int, Int, Int)) {
        self.init()
        self.frame = UInt32(frame)
        self.type = UInt32(type)
        self.params = (Int32(params.0), Int32(params.1), Int32(params.2), Int32(params.3))
    }
    
    var paramArray: [Int] {
        [Int(params.0), Int(params.1), Int(params.2), Int(params.3)]
    }
}
