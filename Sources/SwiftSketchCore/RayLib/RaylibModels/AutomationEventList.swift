import CRaylib

public extension AutomationEventList {
    init(capacity: Int, count: Int, events: UnsafeMutablePointer<AutomationEvent>?) {
        self.init()
        self.capacity = UInt32(capacity)
        self.count = UInt32(count)
        self.events = events
    }
    
    var isEmpty: Bool { count == 0 }
}
