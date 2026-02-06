import CRaylib

public enum Shader {
    public enum UniformValue {
        case float(Float)
        case vec2(Vector2)
        case vec3(Vector3)
        case vec4(Vector4)
        case int(Int32)
        case ivec2(Int32, Int32)
        case ivec3(Int32, Int32, Int32)
        case ivec4(Int32, Int32, Int32, Int32)
        case uint(UInt32)
        case uivec2(UInt32, UInt32)
        case uivec3(UInt32, UInt32, UInt32)
        case uivec4(UInt32, UInt32, UInt32, UInt32)
        case floats([Float], type: ShaderUniformDataType)
        case ints([Int32], type: ShaderUniformDataType)
        case uints([UInt32], type: ShaderUniformDataType)
        case matrix(Matrix)
        case texture(Texture2D)
    }

    public static func begin(_ shader: CRaylib.Shader) {
        BeginShaderMode(shader)
    }

    public static func end() {
        EndShaderMode()
    }

    public static func with<T>(_ shader: CRaylib.Shader, _ body: () -> T) -> T {
        BeginShaderMode(shader)
        defer { EndShaderMode() }
        return body()
    }

    public static func load(vertex: String? = nil, fragment: String? = nil) -> CRaylib.Shader {
        withOptionalCString(vertex) { vertexPtr in
            withOptionalCString(fragment) { fragmentPtr in
                LoadShader(vertexPtr, fragmentPtr)
            }
        }
    }

    public static func loadFromMemory(vertex: String? = nil, fragment: String? = nil) -> CRaylib.Shader {
        withOptionalCString(vertex) { vertexPtr in
            withOptionalCString(fragment) { fragmentPtr in
                LoadShaderFromMemory(vertexPtr, fragmentPtr)
            }
        }
    }

    public static func isValid(_ shader: CRaylib.Shader) -> Bool {
        IsShaderValid(shader)
    }

    public static func location(_ shader: CRaylib.Shader, name: String) -> Int {
        name.withCString { Int(GetShaderLocation(shader, $0)) }
    }

    public static func locationAttrib(_ shader: CRaylib.Shader, name: String) -> Int {
        name.withCString { Int(GetShaderLocationAttrib(shader, $0)) }
    }

    public static func set(_ shader: CRaylib.Shader, name: String, value: UniformValue) {
        let loc = location(shader, name: name)
        guard loc >= 0 else { return }
        set(shader, location: loc, value: value)
    }

    public static func set(_ shader: CRaylib.Shader, location: Int, value: UniformValue) {
        switch value {
        case let .float(value):
            var data = value
            SetShaderValue(shader, Int32(location), &data, Int32(SHADER_UNIFORM_FLOAT.rawValue))
        case let .vec2(value):
            var data = value
            SetShaderValue(shader, Int32(location), &data, Int32(SHADER_UNIFORM_VEC2.rawValue))
        case let .vec3(value):
            var data = value
            SetShaderValue(shader, Int32(location), &data, Int32(SHADER_UNIFORM_VEC3.rawValue))
        case let .vec4(value):
            var data = value
            SetShaderValue(shader, Int32(location), &data, Int32(SHADER_UNIFORM_VEC4.rawValue))
        case let .int(value):
            var data = value
            SetShaderValue(shader, Int32(location), &data, Int32(SHADER_UNIFORM_INT.rawValue))
        case let .ivec2(x, y):
            let data: [Int32] = [x, y]
            data.withUnsafeBytes { buffer in
                SetShaderValue(shader, Int32(location), buffer.baseAddress, Int32(SHADER_UNIFORM_IVEC2.rawValue))
            }
        case let .ivec3(x, y, z):
            let data: [Int32] = [x, y, z]
            data.withUnsafeBytes { buffer in
                SetShaderValue(shader, Int32(location), buffer.baseAddress, Int32(SHADER_UNIFORM_IVEC3.rawValue))
            }
        case let .ivec4(x, y, z, w):
            let data: [Int32] = [x, y, z, w]
            data.withUnsafeBytes { buffer in
                SetShaderValue(shader, Int32(location), buffer.baseAddress, Int32(SHADER_UNIFORM_IVEC4.rawValue))
            }
        case let .uint(value):
            var data = value
            SetShaderValue(shader, Int32(location), &data, Int32(SHADER_UNIFORM_UINT.rawValue))
        case let .uivec2(x, y):
            let data: [UInt32] = [x, y]
            data.withUnsafeBytes { buffer in
                SetShaderValue(shader, Int32(location), buffer.baseAddress, Int32(SHADER_UNIFORM_UIVEC2.rawValue))
            }
        case let .uivec3(x, y, z):
            let data: [UInt32] = [x, y, z]
            data.withUnsafeBytes { buffer in
                SetShaderValue(shader, Int32(location), buffer.baseAddress, Int32(SHADER_UNIFORM_UIVEC3.rawValue))
            }
        case let .uivec4(x, y, z, w):
            let data: [UInt32] = [x, y, z, w]
            data.withUnsafeBytes { buffer in
                SetShaderValue(shader, Int32(location), buffer.baseAddress, Int32(SHADER_UNIFORM_UIVEC4.rawValue))
            }
        case let .floats(values, type):
            values.withUnsafeBufferPointer { buffer in
                SetShaderValueV(shader, Int32(location), buffer.baseAddress, Int32(type.rawValue), Int32(values.count))
            }
        case let .ints(values, type):
            values.withUnsafeBufferPointer { buffer in
                SetShaderValueV(shader, Int32(location), buffer.baseAddress, Int32(type.rawValue), Int32(values.count))
            }
        case let .uints(values, type):
            values.withUnsafeBufferPointer { buffer in
                SetShaderValueV(shader, Int32(location), buffer.baseAddress, Int32(type.rawValue), Int32(values.count))
            }
        case let .matrix(matrix):
            SetShaderValueMatrix(shader, Int32(location), matrix)
        case let .texture(texture):
            SetShaderValueTexture(shader, Int32(location), texture)
        }
    }

    public static func unload(_ shader: CRaylib.Shader) {
        UnloadShader(shader)
    }

    private static func withOptionalCString<T>(_ string: String?, _ body: (UnsafePointer<CChar>?) -> T) -> T {
        guard let string else { return body(nil) }
        return string.withCString { body($0) }
    }
}
