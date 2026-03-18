import CRaylib

public extension Model {
    init(
        transform: Matrix = .identity,
        meshCount: Int,
        materialCount: Int,
        meshes: UnsafeMutablePointer<Mesh>?,
        materials: UnsafeMutablePointer<Material>?,
        meshMaterial: UnsafeMutablePointer<Int32>?,
        boneCount: Int = 0,
        bones: UnsafeMutablePointer<BoneInfo>? = nil,
        bindPose: UnsafeMutablePointer<Transform>? = nil
    ) {
        self.init()
        self.transform = transform
        self.meshCount = Int32(meshCount)
        self.materialCount = Int32(materialCount)
        self.meshes = meshes
        self.materials = materials
        self.meshMaterial = meshMaterial
        self.skeleton = ModelSkeleton()
        self.skeleton.boneCount = Int32(boneCount)
        self.skeleton.bones = bones
        self.skeleton.bindPose = bindPose
    }
    
    var isAnimated: Bool {
        skeleton.boneCount > 0
    }
}
