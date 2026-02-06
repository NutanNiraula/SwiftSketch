import CRaylib

public extension Mesh {
    init(
        vertexCount: Int,
        triangleCount: Int,
        vertices: UnsafeMutablePointer<Float>? = nil,
        texcoords: UnsafeMutablePointer<Float>? = nil,
        texcoords2: UnsafeMutablePointer<Float>? = nil,
        normals: UnsafeMutablePointer<Float>? = nil,
        tangents: UnsafeMutablePointer<Float>? = nil,
        colors: UnsafeMutablePointer<UInt8>? = nil,
        indices: UnsafeMutablePointer<UInt16>? = nil,
        animVertices: UnsafeMutablePointer<Float>? = nil,
        animNormals: UnsafeMutablePointer<Float>? = nil,
        boneIds: UnsafeMutablePointer<UInt8>? = nil,
        boneWeights: UnsafeMutablePointer<Float>? = nil,
        boneMatrices: UnsafeMutablePointer<Matrix>? = nil,
        boneCount: Int = 0,
        vaoId: Int = 0,
        vboId: UnsafeMutablePointer<UInt32>? = nil
    ) {
        self.init()
        self.vertexCount = Int32(vertexCount)
        self.triangleCount = Int32(triangleCount)
        self.vertices = vertices
        self.texcoords = texcoords
        self.texcoords2 = texcoords2
        self.normals = normals
        self.tangents = tangents
        self.colors = colors
        self.indices = indices
        self.animVertices = animVertices
        self.animNormals = animNormals
        self.boneIds = boneIds
        self.boneWeights = boneWeights
        self.boneMatrices = boneMatrices
        self.boneCount = Int32(boneCount)
        self.vaoId = UInt32(vaoId)
        self.vboId = vboId
    }
    
    var isSkinned: Bool {
        boneCount > 0
    }
}
