
import CRaylib

public extension Double {
    static var screenWidth: Double { Double(App.screenWidth) }
    static var screenHeight: Double { Double(App.scrHeight) }
    
    func lerp(to value: Double, _ amount: Double) -> Double {
        Double(Lerp(Float(self), Float(value), Float(amount)))
    }
}
