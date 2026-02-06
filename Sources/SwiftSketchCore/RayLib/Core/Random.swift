import CRaylib

public enum Random {
    public static func setSeed(_ seed: UInt32) { SetRandomSeed(seed) }
    public static func value(min: Int, max: Int) -> Int { Int(GetRandomValue(Int32(min), Int32(max))) }
    public static func loadSequence(count: Int, min: Int, max: Int) -> UnsafeMutablePointer<Int32>? {
        LoadRandomSequence(UInt32(count), Int32(min), Int32(max))
    }
    public static func unloadSequence(_ sequence: UnsafeMutablePointer<Int32>?) {
        UnloadRandomSequence(sequence)
    }
}
