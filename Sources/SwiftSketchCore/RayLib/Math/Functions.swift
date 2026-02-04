import CRaylib

public func lerp(start: Double, end: Double, amount: Double) -> Double {
    Double(Lerp(Float(start), Float(end), Float(amount)))
}

public func map(
    _ value: Double,
    inMin: Double,
    inMax: Double,
    outMin: Double,
    outMax: Double
) -> Double {
    let denom = inMax - inMin
    if denom == 0 { return outMin }
    let t = (value - inMin) / denom
    return outMin + (outMax - outMin) * t
}

public func clamp(_ value: Double, _ minValue: Double, _ maxValue: Double) -> Double {
    if value < minValue { return minValue }
    if value > maxValue { return maxValue }
    return value
}

public func radians(_ degrees: Double) -> Double {
    degrees * Double.pi / 180.0
}

public func degrees(_ radians: Double) -> Double {
    radians * 180.0 / Double.pi
}
