import CRaylib

public extension Material {
    init(
        shader: CRaylib.Shader,
        maps: UnsafeMutablePointer<MaterialMap>?,
        params: (Float, Float, Float, Float) = (0, 0, 0, 0)
    ) {
        self.init()
        self.shader = shader
        self.maps = maps
        self.params = params
    }
    
    func withShader(_ shader: CRaylib.Shader) -> Material {
        Material(shader: shader, maps: maps, params: params)
    }
}
