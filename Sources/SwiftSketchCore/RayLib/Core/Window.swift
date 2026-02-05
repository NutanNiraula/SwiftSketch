import Foundation
import CRaylib

public enum Window {
    public static func open(width: Int, height: Int, title: String) {
        InitWindow(Int32(width), Int32(height), title)
    }

    public static func close() { CloseWindow() }
    public static func shouldClose() -> Bool { WindowShouldClose() }
    public static func isReady() -> Bool { IsWindowReady() }
    public static func isFullscreen() -> Bool { IsWindowFullscreen() }
    public static func isHidden() -> Bool { IsWindowHidden() }
    public static func isMinimized() -> Bool { IsWindowMinimized() }
    public static func isMaximized() -> Bool { IsWindowMaximized() }
    public static func isFocused() -> Bool { IsWindowFocused() }
    public static func isResized() -> Bool { IsWindowResized() }
    public static func isState(_ flag: ConfigFlags) -> Bool { IsWindowState(UInt32(flag.rawValue)) }
    public static func setState(_ flag: ConfigFlags) { SetWindowState(UInt32(flag.rawValue)) }
    public static func clearState(_ flag: ConfigFlags) { ClearWindowState(UInt32(flag.rawValue)) }
    public static func toggleFullscreen() { ToggleFullscreen() }
    public static func toggleBorderlessWindowed() { ToggleBorderlessWindowed() }
    public static func maximize() { MaximizeWindow() }
    public static func minimize() { MinimizeWindow() }
    public static func restore() { RestoreWindow() }
    public static func setIcon(_ image: Image) { SetWindowIcon(image) }
    public static func setTitle(_ title: String) { SetWindowTitle(title) }
    public static func setPosition(x: Int, y: Int) { SetWindowPosition(Int32(x), Int32(y)) }
    public static func setMonitor(_ monitor: Int) { SetWindowMonitor(Int32(monitor)) }
    public static func setMinSize(width: Int, height: Int) { SetWindowMinSize(Int32(width), Int32(height)) }
    public static func setMaxSize(width: Int, height: Int) { SetWindowMaxSize(Int32(width), Int32(height)) }
    public static func setSize(width: Int, height: Int) { SetWindowSize(Int32(width), Int32(height)) }
    public static func setOpacity(_ opacity: Float) { SetWindowOpacity(opacity) }
    public static func setFocused() { SetWindowFocused() }
    public static func getHandle() -> UnsafeMutableRawPointer? { GetWindowHandle() }
    public static func getPosition() -> Vector2 { GetWindowPosition() }
    public static func getScaleDPI() -> Vector2 { GetWindowScaleDPI() }
    public static func renderWidth() -> Int { Int(GetRenderWidth()) }
    public static func renderHeight() -> Int { Int(GetRenderHeight()) }
    public static func screenWidth() -> Int { Int(GetScreenWidth()) }
    public static func screenHeight() -> Int { Int(GetScreenHeight()) }
    public static func getMonitorCount() -> Int { Int(GetMonitorCount()) }
    public static func getCurrentMonitor() -> Int { Int(GetCurrentMonitor()) }
    public static func getMonitorPosition(_ monitor: Int) -> Vector2 { GetMonitorPosition(Int32(monitor)) }
    public static func getMonitorWidth(_ monitor: Int) -> Int { Int(GetMonitorWidth(Int32(monitor))) }
    public static func getMonitorHeight(_ monitor: Int) -> Int { Int(GetMonitorHeight(Int32(monitor))) }
    public static func getMonitorPhysicalWidth(_ monitor: Int) -> Int { Int(GetMonitorPhysicalWidth(Int32(monitor))) }
    public static func getMonitorPhysicalHeight(_ monitor: Int) -> Int { Int(GetMonitorPhysicalHeight(Int32(monitor))) }
    public static func getMonitorRefreshRate(_ monitor: Int) -> Int { Int(GetMonitorRefreshRate(Int32(monitor))) }
    public static func getMonitorName(_ monitor: Int) -> String { String(cString: GetMonitorName(Int32(monitor))) }
    public static func setClipboardText(_ text: String) { SetClipboardText(text) }
    public static func getClipboardText() -> String { String(cString: GetClipboardText()) }
}
