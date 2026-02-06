import CRaylib

public enum Trace {
    public static func setLogLevel(_ level: Int) { SetTraceLogLevel(Int32(level)) }
    public static func setLogCallback(_ callback: TraceLogCallback?) { SetTraceLogCallback(callback) }
}
