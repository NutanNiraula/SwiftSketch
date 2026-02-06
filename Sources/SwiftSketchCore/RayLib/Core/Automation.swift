import CRaylib

public enum Automation {
    public static func loadEventList(_ fileName: String? = nil) -> AutomationEventList {
        if let fileName {
            return fileName.withCString { LoadAutomationEventList($0) }
        }
        return LoadAutomationEventList(nil)
    }
    
    public static func unloadEventList(_ list: AutomationEventList) { UnloadAutomationEventList(list) }
    
    public static func exportEventList(_ list: AutomationEventList, fileName: String) -> Bool {
        fileName.withCString { ExportAutomationEventList(list, $0) }
    }
    
    public static func setEventList(_ list: inout AutomationEventList) {
        withUnsafeMutablePointer(to: &list) { SetAutomationEventList($0) }
    }
    
    public static func setBaseFrame(_ frame: Int) { SetAutomationEventBaseFrame(Int32(frame)) }
    public static func startRecording() { StartAutomationEventRecording() }
    public static func stopRecording() { StopAutomationEventRecording() }
    public static func playEvent(_ event: AutomationEvent) { PlayAutomationEvent(event) }
}
