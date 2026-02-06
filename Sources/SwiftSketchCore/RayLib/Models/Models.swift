#if SS_MINIMAL || SS_NO_MODELS
public enum Models {}
#else
import Foundation
import CRaylib

public enum Models {
    public static func drawLine3D(_ startPos: Vector3, _ endPos: Vector3, color: Color) {
        DrawLine3D(startPos, endPos, color)
    }
    
    public static func drawPoint3D(_ position: Vector3, color: Color) {
        DrawPoint3D(position, color)
    }
    
    public static func drawCircle3D(
        _ center: Vector3,
        radius: Double,
        rotationAxis: Vector3,
        rotationAngle: Double,
        color: Color
    ) {
        DrawCircle3D(center, Float(radius), rotationAxis, Float(rotationAngle), color)
    }
    
    public static func drawTriangle3D(_ v1: Vector3, _ v2: Vector3, _ v3: Vector3, color: Color) {
        DrawTriangle3D(v1, v2, v3, color)
    }
    
    public static func drawTriangleStrip3D(_ points: [Vector3], color: Color) {
        guard !points.isEmpty else { return }
        points.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawTriangleStrip3D(base, Int32(buffer.count), color)
        }
    }
    
    public static func drawCube(_ position: Vector3, width: Double, height: Double, length: Double, color: Color) {
        DrawCube(position, Float(width), Float(height), Float(length), color)
    }
    
    public static func drawCubeV(_ position: Vector3, size: Vector3, color: Color) {
        DrawCubeV(position, size, color)
    }
    
    public static func drawCubeWires(_ position: Vector3, width: Double, height: Double, length: Double, color: Color) {
        DrawCubeWires(position, Float(width), Float(height), Float(length), color)
    }
    
    public static func drawCubeWiresV(_ position: Vector3, size: Vector3, color: Color) {
        DrawCubeWiresV(position, size, color)
    }
    
    public static func drawSphere(_ centerPos: Vector3, radius: Double, color: Color) {
        DrawSphere(centerPos, Float(radius), color)
    }
    
    public static func drawSphereEx(_ centerPos: Vector3, radius: Double, rings: Int, slices: Int, color: Color) {
        DrawSphereEx(centerPos, Float(radius), Int32(rings), Int32(slices), color)
    }
    
    public static func drawSphereWires(_ centerPos: Vector3, radius: Double, rings: Int, slices: Int, color: Color) {
        DrawSphereWires(centerPos, Float(radius), Int32(rings), Int32(slices), color)
    }
    
    public static func drawCylinder(
        _ position: Vector3,
        radiusTop: Double,
        radiusBottom: Double,
        height: Double,
        slices: Int,
        color: Color
    ) {
        DrawCylinder(position, Float(radiusTop), Float(radiusBottom), Float(height), Int32(slices), color)
    }
    
    public static func drawCylinderEx(
        _ startPos: Vector3,
        _ endPos: Vector3,
        radiusTop: Double,
        radiusBottom: Double,
        sides: Int,
        color: Color
    ) {
        DrawCylinderEx(startPos, endPos, Float(radiusTop), Float(radiusBottom), Int32(sides), color)
    }
    
    public static func drawCylinderWires(
        _ position: Vector3,
        radiusTop: Double,
        radiusBottom: Double,
        height: Double,
        slices: Int,
        color: Color
    ) {
        DrawCylinderWires(position, Float(radiusTop), Float(radiusBottom), Float(height), Int32(slices), color)
    }
    
    public static func drawCylinderWiresEx(
        _ startPos: Vector3,
        _ endPos: Vector3,
        radiusTop: Double,
        radiusBottom: Double,
        sides: Int,
        color: Color
    ) {
        DrawCylinderWiresEx(startPos, endPos, Float(radiusTop), Float(radiusBottom), Int32(sides), color)
    }
    
    public static func drawCapsule(
        _ startPos: Vector3,
        _ endPos: Vector3,
        radius: Double,
        slices: Int,
        rings: Int,
        color: Color
    ) {
        DrawCapsule(startPos, endPos, Float(radius), Int32(slices), Int32(rings), color)
    }
    
    public static func drawCapsuleWires(
        _ startPos: Vector3,
        _ endPos: Vector3,
        radius: Double,
        slices: Int,
        rings: Int,
        color: Color
    ) {
        DrawCapsuleWires(startPos, endPos, Float(radius), Int32(slices), Int32(rings), color)
    }
    
    public static func drawPlane(_ centerPos: Vector3, size: Vector2, color: Color) {
        DrawPlane(centerPos, size, color)
    }
    
    public static func drawRay(_ ray: CRaylib.Ray, color: Color) {
        DrawRay(ray, color)
    }
    
    public static func drawGrid(_ slices: Int, spacing: Double) {
        DrawGrid(Int32(slices), Float(spacing))
    }
    
    public static func loadModel(_ fileName: String) -> Model {
        fileName.withCString { LoadModel($0) }
    }
    
    public static func loadModelFromMesh(_ mesh: Mesh) -> Model {
        LoadModelFromMesh(mesh)
    }
    
    public static func isModelValid(_ model: Model) -> Bool {
        IsModelValid(model)
    }
    
    public static func unloadModel(_ model: Model) {
        UnloadModel(model)
    }
    
    public static func getModelBoundingBox(_ model: Model) -> BoundingBox {
        GetModelBoundingBox(model)
    }
    
    public static func drawModel(_ model: Model, position: Vector3, scale: Double, tint: Color) {
        DrawModel(model, position, Float(scale), tint)
    }
    
    public static func drawModelEx(
        _ model: Model,
        position: Vector3,
        rotationAxis: Vector3,
        rotationAngle: Double,
        scale: Vector3,
        tint: Color
    ) {
        DrawModelEx(model, position, rotationAxis, Float(rotationAngle), scale, tint)
    }
    
    public static func drawModelWires(_ model: Model, position: Vector3, scale: Double, tint: Color) {
        DrawModelWires(model, position, Float(scale), tint)
    }
    
    public static func drawModelWiresEx(
        _ model: Model,
        position: Vector3,
        rotationAxis: Vector3,
        rotationAngle: Double,
        scale: Vector3,
        tint: Color
    ) {
        DrawModelWiresEx(model, position, rotationAxis, Float(rotationAngle), scale, tint)
    }
    
    public static func drawModelPoints(_ model: Model, position: Vector3, scale: Double, tint: Color) {
        DrawModelPoints(model, position, Float(scale), tint)
    }
    
    public static func drawModelPointsEx(
        _ model: Model,
        position: Vector3,
        rotationAxis: Vector3,
        rotationAngle: Double,
        scale: Vector3,
        tint: Color
    ) {
        DrawModelPointsEx(model, position, rotationAxis, Float(rotationAngle), scale, tint)
    }
    
    public static func drawBoundingBox(_ box: BoundingBox, color: Color) {
        DrawBoundingBox(box, color)
    }
    
    public static func drawBillboard(
        _ camera: CRaylib.Camera,
        texture: Texture2D,
        position: Vector3,
        scale: Double,
        tint: Color
    ) {
        DrawBillboard(camera, texture, position, Float(scale), tint)
    }
    
    public static func drawBillboardRec(
        _ camera: CRaylib.Camera,
        texture: Texture2D,
        source: Rectangle,
        position: Vector3,
        size: Vector2,
        tint: Color
    ) {
        DrawBillboardRec(camera, texture, source, position, size, tint)
    }
    
    public static func drawBillboardPro(
        _ camera: CRaylib.Camera,
        texture: Texture2D,
        source: Rectangle,
        position: Vector3,
        up: Vector3,
        size: Vector2,
        origin: Vector2,
        rotation: Double,
        tint: Color
    ) {
        DrawBillboardPro(camera, texture, source, position, up, size, origin, Float(rotation), tint)
    }
    
    public static func uploadMesh(_ mesh: inout Mesh, dynamic: Bool) {
        withUnsafeMutablePointer(to: &mesh) { UploadMesh($0, dynamic) }
    }
    
    public static func updateMeshBuffer(
        _ mesh: Mesh,
        index: Int,
        data: UnsafeRawPointer,
        dataSize: Int,
        offset: Int
    ) {
        UpdateMeshBuffer(mesh, Int32(index), data, Int32(dataSize), Int32(offset))
    }
    
    public static func unloadMesh(_ mesh: Mesh) {
        UnloadMesh(mesh)
    }
    
    public static func drawMesh(_ mesh: Mesh, material: Material, transform: Matrix) {
        DrawMesh(mesh, material, transform)
    }
    
    public static func drawMeshInstanced(
        _ mesh: Mesh,
        material: Material,
        transforms: [Matrix]
    ) {
        guard !transforms.isEmpty else { return }
        transforms.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawMeshInstanced(mesh, material, base, Int32(buffer.count))
        }
    }
    
    public static func getMeshBoundingBox(_ mesh: Mesh) -> BoundingBox {
        GetMeshBoundingBox(mesh)
    }
    
    public static func genMeshTangents(_ mesh: inout Mesh) {
        withUnsafeMutablePointer(to: &mesh) { GenMeshTangents($0) }
    }
    
    public static func exportMesh(_ mesh: Mesh, fileName: String) -> Bool {
        fileName.withCString { ExportMesh(mesh, $0) }
    }
    
    public static func exportMeshAsCode(_ mesh: Mesh, fileName: String) -> Bool {
        fileName.withCString { ExportMeshAsCode(mesh, $0) }
    }
    
    public static func genMeshPoly(sides: Int, radius: Double) -> Mesh {
        GenMeshPoly(Int32(sides), Float(radius))
    }
    
    public static func genMeshPlane(width: Double, length: Double, resX: Int, resZ: Int) -> Mesh {
        GenMeshPlane(Float(width), Float(length), Int32(resX), Int32(resZ))
    }
    
    public static func genMeshCube(width: Double, height: Double, length: Double) -> Mesh {
        GenMeshCube(Float(width), Float(height), Float(length))
    }
    
    public static func genMeshSphere(radius: Double, rings: Int, slices: Int) -> Mesh {
        GenMeshSphere(Float(radius), Int32(rings), Int32(slices))
    }
    
    public static func genMeshHemiSphere(radius: Double, rings: Int, slices: Int) -> Mesh {
        GenMeshHemiSphere(Float(radius), Int32(rings), Int32(slices))
    }
    
    public static func genMeshCylinder(radius: Double, height: Double, slices: Int) -> Mesh {
        GenMeshCylinder(Float(radius), Float(height), Int32(slices))
    }
    
    public static func genMeshCone(radius: Double, height: Double, slices: Int) -> Mesh {
        GenMeshCone(Float(radius), Float(height), Int32(slices))
    }
    
    public static func genMeshTorus(radius: Double, size: Double, radSeg: Int, sides: Int) -> Mesh {
        GenMeshTorus(Float(radius), Float(size), Int32(radSeg), Int32(sides))
    }
    
    public static func genMeshKnot(radius: Double, size: Double, radSeg: Int, sides: Int) -> Mesh {
        GenMeshKnot(Float(radius), Float(size), Int32(radSeg), Int32(sides))
    }
    
    public static func genMeshHeightmap(_ heightmap: Image, size: Vector3) -> Mesh {
        GenMeshHeightmap(heightmap, size)
    }
    
    public static func genMeshCubicmap(_ cubicmap: Image, cubeSize: Vector3) -> Mesh {
        GenMeshCubicmap(cubicmap, cubeSize)
    }
    
    public static func loadMaterials(
        _ fileName: String,
        materialCount: UnsafeMutablePointer<Int32>? = nil
    ) -> UnsafeMutablePointer<Material>? {
        fileName.withCString { LoadMaterials($0, materialCount) }
    }
    
    public static func loadMaterialDefault() -> Material {
        LoadMaterialDefault()
    }
    
    public static func isMaterialValid(_ material: Material) -> Bool {
        IsMaterialValid(material)
    }
    
    public static func unloadMaterial(_ material: Material) {
        UnloadMaterial(material)
    }
    
    public static func setMaterialTexture(
        _ material: inout Material,
        mapType: Int,
        texture: Texture2D
    ) {
        withUnsafeMutablePointer(to: &material) {
            SetMaterialTexture($0, Int32(mapType), texture)
        }
    }
    
    public static func setModelMeshMaterial(
        _ model: inout Model,
        meshId: Int,
        materialId: Int
    ) {
        withUnsafeMutablePointer(to: &model) {
            SetModelMeshMaterial($0, Int32(meshId), Int32(materialId))
        }
    }
    
    public static func loadModelAnimations(
        _ fileName: String,
        animCount: UnsafeMutablePointer<Int32>? = nil
    ) -> UnsafeMutablePointer<ModelAnimation>? {
        fileName.withCString { LoadModelAnimations($0, animCount) }
    }
    
    public static func updateModelAnimation(_ model: Model, anim: ModelAnimation, frame: Int) {
        UpdateModelAnimation(model, anim, Int32(frame))
    }
    
    public static func updateModelAnimationBones(_ model: Model, anim: ModelAnimation, frame: Int) {
        UpdateModelAnimationBones(model, anim, Int32(frame))
    }
    
    public static func unloadModelAnimation(_ anim: ModelAnimation) {
        UnloadModelAnimation(anim)
    }
    
    public static func unloadModelAnimations(_ animations: UnsafeMutablePointer<ModelAnimation>?, animCount: Int) {
        UnloadModelAnimations(animations, Int32(animCount))
    }
    
    public static func isModelAnimationValid(_ model: Model, anim: ModelAnimation) -> Bool {
        IsModelAnimationValid(model, anim)
    }
    
    public static func checkCollisionSpheres(
        _ center1: Vector3,
        radius1: Double,
        _ center2: Vector3,
        radius2: Double
    ) -> Bool {
        CheckCollisionSpheres(center1, Float(radius1), center2, Float(radius2))
    }
    
    public static func checkCollisionBoxes(_ box1: BoundingBox, _ box2: BoundingBox) -> Bool {
        CheckCollisionBoxes(box1, box2)
    }
    
    public static func checkCollisionBoxSphere(
        _ box: BoundingBox,
        center: Vector3,
        radius: Double
    ) -> Bool {
        CheckCollisionBoxSphere(box, center, Float(radius))
    }
    
    public static func getRayCollisionSphere(_ ray: CRaylib.Ray, center: Vector3, radius: Double) -> RayCollision {
        GetRayCollisionSphere(ray, center, Float(radius))
    }
    
    public static func getRayCollisionBox(_ ray: CRaylib.Ray, box: BoundingBox) -> RayCollision {
        GetRayCollisionBox(ray, box)
    }
    
    public static func getRayCollisionMesh(_ ray: CRaylib.Ray, mesh: Mesh, transform: Matrix) -> RayCollision {
        GetRayCollisionMesh(ray, mesh, transform)
    }
    
    public static func getRayCollisionTriangle(
        _ ray: CRaylib.Ray,
        p1: Vector3,
        p2: Vector3,
        p3: Vector3
    ) -> RayCollision {
        GetRayCollisionTriangle(ray, p1, p2, p3)
    }
    
    public static func getRayCollisionQuad(
        _ ray: CRaylib.Ray,
        p1: Vector3,
        p2: Vector3,
        p3: Vector3,
        p4: Vector3
    ) -> RayCollision {
        GetRayCollisionQuad(ray, p1, p2, p3, p4)
    }
}
#endif
