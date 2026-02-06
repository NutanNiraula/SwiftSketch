import CRaylib

public enum VR {
    public static func beginStereoMode(_ config: VrStereoConfig) {
        BeginVrStereoMode(config)
    }
    
    public static func endStereoMode() {
        EndVrStereoMode()
    }
    
    public static func loadStereoConfig(_ device: VrDeviceInfo) -> VrStereoConfig {
        LoadVrStereoConfig(device)
    }
    
    public static func unloadStereoConfig(_ config: VrStereoConfig) {
        UnloadVrStereoConfig(config)
    }
}
