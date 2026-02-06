import CRaylib

public extension VrStereoConfig {
    init(
        projection: (Matrix, Matrix),
        viewOffset: (Matrix, Matrix),
        leftLensCenter: (Float, Float),
        rightLensCenter: (Float, Float),
        leftScreenCenter: (Float, Float),
        rightScreenCenter: (Float, Float),
        scale: (Float, Float),
        scaleIn: (Float, Float)
    ) {
        self.init()
        self.projection = projection
        self.viewOffset = viewOffset
        self.leftLensCenter = leftLensCenter
        self.rightLensCenter = rightLensCenter
        self.leftScreenCenter = leftScreenCenter
        self.rightScreenCenter = rightScreenCenter
        self.scale = scale
        self.scaleIn = scaleIn
    }
    
    var leftProjection: Matrix { projection.0 }
    var rightProjection: Matrix { projection.1 }
}
