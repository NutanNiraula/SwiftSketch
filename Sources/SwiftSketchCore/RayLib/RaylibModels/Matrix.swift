import CRaylib

public extension Matrix {
    init(_ values: [Double]) {
        precondition(values.count == 16)
        self.init(
            m0: Float(values[0]), m4: Float(values[4]), m8: Float(values[8]), m12: Float(values[12]),
            m1: Float(values[1]), m5: Float(values[5]), m9: Float(values[9]), m13: Float(values[13]),
            m2: Float(values[2]), m6: Float(values[6]), m10: Float(values[10]), m14: Float(values[14]),
            m3: Float(values[3]), m7: Float(values[7]), m11: Float(values[11]), m15: Float(values[15])
        )
    }
    
    static var identity: Matrix { MatrixIdentity() }
    
    func multiplied(by other: Matrix) -> Matrix {
        MatrixMultiply(self, other)
    }
}
