import Foundation
import CRaylib

public func isWindowReady() -> Bool { IsWindowReady() }

public func isWindowFullscreen() -> Bool { IsWindowFullscreen() }

public func isWindowHidden() -> Bool { IsWindowHidden() }

public func isWindowMinimized() -> Bool { IsWindowMinimized() }

public func isWindowMaximized() -> Bool { IsWindowMaximized() }

public func isWindowFocused() -> Bool { IsWindowFocused() }

public func isWindowResized() -> Bool { IsWindowResized() }

public func isWindowState(_ state: UInt32) -> Bool { IsWindowState(state) }

public func setWindowState(_ state: UInt32) { SetWindowState(state) }

public func clearWindowState(_ state: UInt32) { ClearWindowState(state) }

public func toggleFullscreen() { ToggleFullscreen() }

public func maximizeWindow() { MaximizeWindow() }

public func minimizeWindow() { MinimizeWindow() }

public func restoreWindow() { RestoreWindow() }

public func setWindowIcon(_ image: Image) { SetWindowIcon(image) }

public func setWindowTitle(_ title: String) { SetWindowTitle(title) }

public func setWindowPosition(x: Int, y: Int) { SetWindowPosition(Int32(x), Int32(y)) }

public func setWindowMonitor(_ monitor: Int) { SetWindowMonitor(Int32(monitor)) }

public func setWindowMinSize(width: Int, height: Int) { SetWindowMinSize(Int32(width), Int32(height)) }

public func setWindowSize(width: Int, height: Int) { SetWindowSize(Int32(width), Int32(height)) }

public func getScreenWidth() -> Int { Int(GetScreenWidth()) }

public func getScreenHeight() -> Int { Int(GetScreenHeight()) }

public func getMonitorCount() -> Int { Int(GetMonitorCount()) }

public func getCurrentMonitor() -> Int { Int(GetCurrentMonitor()) }

public func getMonitorPosition(_ monitor: Int) -> Vector2 { GetMonitorPosition(Int32(monitor)) }

public func getMonitorWidth(_ monitor: Int) -> Int { Int(GetMonitorWidth(Int32(monitor))) }

public func getMonitorHeight(_ monitor: Int) -> Int { Int(GetMonitorHeight(Int32(monitor))) }

public func getMonitorPhysicalWidth(_ monitor: Int) -> Int { Int(GetMonitorPhysicalWidth(Int32(monitor))) }

public func getMonitorPhysicalHeight(_ monitor: Int) -> Int { Int(GetMonitorPhysicalHeight(Int32(monitor))) }

public func getMonitorRefreshRate(_ monitor: Int) -> Int { Int(GetMonitorRefreshRate(Int32(monitor))) }

public func getWindowPosition() -> Vector2 { GetWindowPosition() }

public func getWindowScaleDPI() -> Vector2 { GetWindowScaleDPI() }

public func getClipboardText() -> String { String(cString: GetClipboardText()) }

public func setClipboardText(_ text: String) { SetClipboardText(text) }
