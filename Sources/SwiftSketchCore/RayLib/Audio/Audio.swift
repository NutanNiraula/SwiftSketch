#if SS_MINIMAL || SS_NO_AUDIO
public enum Audio {}
#else
import Foundation
import CRaylib

public enum Audio {
    public static func initDevice() {
        InitAudioDevice()
    }
    
    public static func closeDevice() {
        CloseAudioDevice()
    }
    
    public static func isDeviceReady() -> Bool {
        IsAudioDeviceReady()
    }
    
    public static func setMasterVolume(_ volume: Double) {
        SetMasterVolume(Float(volume))
    }
    
    public static func masterVolume() -> Double {
        Double(GetMasterVolume())
    }
    
    public static func loadWave(_ fileName: String) -> Wave {
        fileName.withCString { LoadWave($0) }
    }
    
    public static func loadWaveFromMemory(
        _ fileType: String,
        data: UnsafePointer<UInt8>,
        dataSize: Int
    ) -> Wave {
        fileType.withCString { LoadWaveFromMemory($0, data, Int32(dataSize)) }
    }
    
    public static func isWaveValid(_ wave: Wave) -> Bool {
        IsWaveValid(wave)
    }
    
    public static func loadSound(_ fileName: String) -> Sound {
        fileName.withCString { LoadSound($0) }
    }
    
    public static func loadSoundFromWave(_ wave: Wave) -> Sound {
        LoadSoundFromWave(wave)
    }
    
    public static func loadSoundAlias(_ sound: Sound) -> Sound {
        LoadSoundAlias(sound)
    }
    
    public static func isSoundValid(_ sound: Sound) -> Bool {
        IsSoundValid(sound)
    }
    
    public static func updateSound(_ sound: Sound, data: UnsafeRawPointer, sampleCount: Int) {
        UpdateSound(sound, data, Int32(sampleCount))
    }
    
    public static func updateSound(_ sound: Sound, samples: [Float]) {
        samples.withUnsafeBytes { buffer in
            guard let base = buffer.baseAddress else { return }
            UpdateSound(sound, base, Int32(samples.count))
        }
    }
    
    public static func unloadWave(_ wave: Wave) {
        UnloadWave(wave)
    }
    
    public static func unloadSound(_ sound: Sound) {
        UnloadSound(sound)
    }
    
    public static func unloadSoundAlias(_ sound: Sound) {
        UnloadSoundAlias(sound)
    }
    
    public static func exportWave(_ wave: Wave, fileName: String) -> Bool {
        fileName.withCString { ExportWave(wave, $0) }
    }
    
    public static func exportWaveAsCode(_ wave: Wave, fileName: String) -> Bool {
        fileName.withCString { ExportWaveAsCode(wave, $0) }
    }
    
    public static func playSound(_ sound: Sound) {
        PlaySound(sound)
    }
    
    public static func stopSound(_ sound: Sound) {
        StopSound(sound)
    }
    
    public static func pauseSound(_ sound: Sound) {
        PauseSound(sound)
    }
    
    public static func resumeSound(_ sound: Sound) {
        ResumeSound(sound)
    }
    
    public static func isSoundPlaying(_ sound: Sound) -> Bool {
        IsSoundPlaying(sound)
    }
    
    public static func setSoundVolume(_ sound: Sound, volume: Double) {
        SetSoundVolume(sound, Float(volume))
    }
    
    public static func setSoundPitch(_ sound: Sound, pitch: Double) {
        SetSoundPitch(sound, Float(pitch))
    }
    
    public static func setSoundPan(_ sound: Sound, pan: Double) {
        SetSoundPan(sound, Float(pan))
    }
    
    public static func waveCopy(_ wave: Wave) -> Wave {
        WaveCopy(wave)
    }
    
    public static func waveCrop(_ wave: inout Wave, startSample: Int, endSample: Int) {
        withUnsafeMutablePointer(to: &wave) {
            WaveCrop($0, Int32(startSample), Int32(endSample))
        }
    }
    
    public static func waveFormat(_ wave: inout Wave, sampleRate: Int, sampleSize: Int, channels: Int) {
        withUnsafeMutablePointer(to: &wave) {
            WaveFormat($0, Int32(sampleRate), Int32(sampleSize), Int32(channels))
        }
    }
    
    public static func loadWaveSamples(_ wave: Wave) -> UnsafeMutablePointer<Float>? {
        LoadWaveSamples(wave)
    }
    
    public static func unloadWaveSamples(_ samples: UnsafeMutablePointer<Float>?) {
        UnloadWaveSamples(samples)
    }
    
    public static func loadMusicStream(_ fileName: String) -> Music {
        fileName.withCString { LoadMusicStream($0) }
    }
    
    public static func loadMusicStreamFromMemory(
        _ fileType: String,
        data: UnsafePointer<UInt8>,
        dataSize: Int
    ) -> Music {
        fileType.withCString { LoadMusicStreamFromMemory($0, data, Int32(dataSize)) }
    }
    
    public static func isMusicValid(_ music: Music) -> Bool {
        IsMusicValid(music)
    }
    
    public static func unloadMusicStream(_ music: Music) {
        UnloadMusicStream(music)
    }
    
    public static func playMusicStream(_ music: Music) {
        PlayMusicStream(music)
    }
    
    public static func isMusicStreamPlaying(_ music: Music) -> Bool {
        IsMusicStreamPlaying(music)
    }
    
    public static func updateMusicStream(_ music: Music) {
        UpdateMusicStream(music)
    }
    
    public static func stopMusicStream(_ music: Music) {
        StopMusicStream(music)
    }
    
    public static func pauseMusicStream(_ music: Music) {
        PauseMusicStream(music)
    }
    
    public static func resumeMusicStream(_ music: Music) {
        ResumeMusicStream(music)
    }
    
    public static func seekMusicStream(_ music: Music, position: Double) {
        SeekMusicStream(music, Float(position))
    }
    
    public static func setMusicVolume(_ music: Music, volume: Double) {
        SetMusicVolume(music, Float(volume))
    }
    
    public static func setMusicPitch(_ music: Music, pitch: Double) {
        SetMusicPitch(music, Float(pitch))
    }
    
    public static func setMusicPan(_ music: Music, pan: Double) {
        SetMusicPan(music, Float(pan))
    }
    
    public static func getMusicTimeLength(_ music: Music) -> Double {
        Double(GetMusicTimeLength(music))
    }
    
    public static func getMusicTimePlayed(_ music: Music) -> Double {
        Double(GetMusicTimePlayed(music))
    }
    
    public static func loadAudioStream(sampleRate: Int, sampleSize: Int, channels: Int) -> AudioStream {
        LoadAudioStream(UInt32(sampleRate), UInt32(sampleSize), UInt32(channels))
    }
    
    public static func isAudioStreamValid(_ stream: AudioStream) -> Bool {
        IsAudioStreamValid(stream)
    }
    
    public static func unloadAudioStream(_ stream: AudioStream) {
        UnloadAudioStream(stream)
    }
    
    public static func updateAudioStream(_ stream: AudioStream, data: UnsafeRawPointer, frameCount: Int) {
        UpdateAudioStream(stream, data, Int32(frameCount))
    }
    
    public static func updateAudioStream(_ stream: AudioStream, samples: [Float]) {
        samples.withUnsafeBytes { buffer in
            guard let base = buffer.baseAddress else { return }
            UpdateAudioStream(stream, base, Int32(samples.count))
        }
    }
    
    public static func isAudioStreamProcessed(_ stream: AudioStream) -> Bool {
        IsAudioStreamProcessed(stream)
    }
    
    public static func playAudioStream(_ stream: AudioStream) {
        PlayAudioStream(stream)
    }
    
    public static func pauseAudioStream(_ stream: AudioStream) {
        PauseAudioStream(stream)
    }
    
    public static func resumeAudioStream(_ stream: AudioStream) {
        ResumeAudioStream(stream)
    }
    
    public static func isAudioStreamPlaying(_ stream: AudioStream) -> Bool {
        IsAudioStreamPlaying(stream)
    }
    
    public static func stopAudioStream(_ stream: AudioStream) {
        StopAudioStream(stream)
    }
    
    public static func setAudioStreamVolume(_ stream: AudioStream, volume: Double) {
        SetAudioStreamVolume(stream, Float(volume))
    }
    
    public static func setAudioStreamPitch(_ stream: AudioStream, pitch: Double) {
        SetAudioStreamPitch(stream, Float(pitch))
    }
    
    public static func setAudioStreamPan(_ stream: AudioStream, pan: Double) {
        SetAudioStreamPan(stream, Float(pan))
    }
    
    public static func setAudioStreamBufferSizeDefault(_ size: Int) {
        SetAudioStreamBufferSizeDefault(Int32(size))
    }
    
    public static func setAudioStreamCallback(_ stream: AudioStream, _ callback: AudioCallback) {
        SetAudioStreamCallback(stream, callback)
    }
    
    public static func attachAudioStreamProcessor(_ stream: AudioStream, _ processor: AudioCallback) {
        AttachAudioStreamProcessor(stream, processor)
    }
    
    public static func detachAudioStreamProcessor(_ stream: AudioStream, _ processor: AudioCallback) {
        DetachAudioStreamProcessor(stream, processor)
    }
    
    public static func attachAudioMixedProcessor(_ processor: AudioCallback) {
        AttachAudioMixedProcessor(processor)
    }
    
    public static func detachAudioMixedProcessor(_ processor: AudioCallback) {
        DetachAudioMixedProcessor(processor)
    }
}
#endif
