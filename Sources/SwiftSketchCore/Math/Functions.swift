import CRaylib

public func lerp(start: Double, end: Double, amount: Double) -> Double {
    Double(Lerp(Float(start), Float(end), Float(amount)))
}
