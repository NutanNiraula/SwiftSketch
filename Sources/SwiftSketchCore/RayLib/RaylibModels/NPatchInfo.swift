import CRaylib

public extension NPatchInfo {
    init(source: Rectangle, left: Int, top: Int, right: Int, bottom: Int, layout: Int) {
        self.init()
        self.source = source
        self.left = Int32(left)
        self.top = Int32(top)
        self.right = Int32(right)
        self.bottom = Int32(bottom)
        self.layout = Int32(layout)
    }
    
    var padding: (left: Int, top: Int, right: Int, bottom: Int) {
        (Int(left), Int(top), Int(right), Int(bottom))
    }
}
