import CRaylib

public extension VrDeviceInfo {
    init(
        hResolution: Int,
        vResolution: Int,
        hScreenSize: Double,
        vScreenSize: Double,
        eyeToScreenDistance: Double,
        lensSeparationDistance: Double,
        interpupillaryDistance: Double,
        lensDistortionValues: (Float, Float, Float, Float),
        chromaAbCorrection: (Float, Float, Float, Float)
    ) {
        self.init(
            hResolution: Int32(hResolution),
            vResolution: Int32(vResolution),
            hScreenSize: Float(hScreenSize),
            vScreenSize: Float(vScreenSize),
            eyeToScreenDistance: Float(eyeToScreenDistance),
            lensSeparationDistance: Float(lensSeparationDistance),
            interpupillaryDistance: Float(interpupillaryDistance),
            lensDistortionValues: lensDistortionValues,
            chromaAbCorrection: chromaAbCorrection
        )
    }
    
    var resolution: (width: Int, height: Int) {
        (Int(hResolution), Int(vResolution))
    }
}
