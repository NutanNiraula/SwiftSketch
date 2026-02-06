import CRaylib

public enum System {
    public static func swapScreenBuffer() { SwapScreenBuffer() }
    public static func pollInputEvents() { PollInputEvents() }
    public static func wait(_ seconds: Double) { WaitTime(seconds) }
    public static func takeScreenshot(_ fileName: String) {
        fileName.withCString { TakeScreenshot($0) }
    }
    public static func setConfigFlags(_ flags: UInt32) { SetConfigFlags(flags) }
    public static func openURL(_ url: String) { url.withCString { OpenURL($0) } }
}
