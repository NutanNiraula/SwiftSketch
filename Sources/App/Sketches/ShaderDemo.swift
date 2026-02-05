import SwiftSketchCore

public final class ShaderDemo: Sketch {
    private var shader: CRaylib.Shader?
    private var timeLocation: Int = -1
    private var resolutionLocation: Int = -1
    private var shaderValid = false
    
    public init() {}
    
    public func setup() {
        App.initWindow(w: 1280, h: 720, title: "Shader Demo", targetFPS: 60, bgColor: .black)
        App.fps(true)
        
        let vertex = """
#version 100
#ifdef GL_ES
precision mediump float;
#endif
attribute vec3 vertexPosition;
attribute vec2 vertexTexCoord;
attribute vec4 vertexColor;
varying vec2 vUV;
varying vec4 vColor;
uniform mat4 mvp;
void main() {
    vUV = vertexTexCoord;
    vColor = vertexColor;
    gl_Position = mvp * vec4(vertexPosition, 1.0);
}
"""
        let fragment = """
#version 100
#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 iResolution;
uniform float iTime;
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}
float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}
float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.55;
    float frequency = 1.0;
    for (int i = 0; i < 5; i++) {
        value += amplitude * noise(p * frequency);
        frequency *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}
void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec2 p = uv * 2.0 - 1.0;
    p.x *= iResolution.x / iResolution.y;
    float r = length(p);
    float centerMask = smoothstep(1.2, 0.0, r);
    float t = iTime * 0.12;
    float n1 = fbm(p * 1.8 + vec2(t, -t * 0.6));
    float n2 = fbm(p * 3.2 - vec2(t * 0.4, t * 0.25));
    float n3 = fbm(p * 7.0 + vec2(t * 0.9, t * 0.15));
    float nebula = n1 * 0.6 + n2 * 0.28 + n3 * 0.12;
    nebula = pow(nebula, 2.5) * centerMask;
    vec3 baseA = vec3(0.05, 0.03, 0.12);
    vec3 baseB = vec3(0.6, 0.12, 0.75);
    vec3 baseC = vec3(0.2, 0.55, 1.0);
    vec3 col = mix(baseA, baseB, nebula);
    col = mix(col, baseC, n2 * 0.65);
    float dust = fbm(p * 12.0 - t * 0.6);
    col += vec3(0.2, 0.1, 0.25) * dust * dust * centerMask;
    float starSeed = hash(floor((p + 2.0) * 140.0));
    float stars = smoothstep(0.996, 1.0, starSeed) * centerMask;
    col += vec3(1.6, 1.3, 1.9) * stars;
    float glow = smoothstep(0.1, 0.8, nebula);
    col += vec3(0.6, 0.3, 0.9) * glow * 0.4;
    col *= 1.25;
    col *= mix(0.2, 1.0, centerMask);
    col = clamp(col, 0.0, 1.0);
    gl_FragColor = vec4(col, 1.0);
}
"""
        let loaded = Shader.loadFromMemory(vertex: vertex, fragment: fragment)
        shader = loaded
        shaderValid = Shader.isValid(loaded)
        timeLocation = Shader.location(loaded, name: "iTime")
        resolutionLocation = Shader.location(loaded, name: "iResolution")
    }
    
    public func update() {}
    
    public func draw() {
        guard let shader else { return }
        if !shaderValid {
            Render.clearBackground(.black)
            Text.draw("Shader failed to compile", x: 20, y: 20, size: 20, color: .white)
            return
        }
        let w = Render.renderWidth()
        let h = Render.renderHeight()
        if w <= 0 || h <= 0 { return }
        let time = Float(Render.timeSeconds())
        let resolution = Vector2(Double(w), Double(h))
        if resolutionLocation >= 0 {
            Shader.set(shader, location: resolutionLocation, value: .vec2(resolution))
        }
        if timeLocation >= 0 {
            Shader.set(shader, location: timeLocation, value: .float(time))
        }
        Shader.with(shader) {
            DrawRectangle(0, 0, Int32(w), Int32(h), .white)
        }
    }
}
