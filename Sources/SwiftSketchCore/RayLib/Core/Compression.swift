import CRaylib

public enum Compression {
    public static func compress(_ data: UnsafePointer<UInt8>, size: Int, outSize: UnsafeMutablePointer<Int32>? = nil) -> UnsafeMutablePointer<UInt8>? {
        CompressData(data, Int32(size), outSize)
    }
    
    public static func decompress(_ data: UnsafePointer<UInt8>, size: Int, outSize: UnsafeMutablePointer<Int32>? = nil) -> UnsafeMutablePointer<UInt8>? {
        DecompressData(data, Int32(size), outSize)
    }
    
    public static func encodeBase64(_ data: UnsafePointer<UInt8>, size: Int, outSize: UnsafeMutablePointer<Int32>? = nil) -> UnsafeMutablePointer<CChar>? {
        EncodeDataBase64(data, Int32(size), outSize)
    }
    
    public static func decodeBase64(_ data: UnsafePointer<CChar>, outSize: UnsafeMutablePointer<Int32>? = nil) -> UnsafeMutablePointer<UInt8>? {
        DecodeDataBase64(data, outSize)
    }
    
    public static func crc32(_ data: UnsafePointer<UInt8>, size: Int) -> UInt32 {
        ComputeCRC32(UnsafeMutablePointer(mutating: data), Int32(size))
    }
    
    public static func md5(_ data: UnsafePointer<UInt8>, size: Int) -> UnsafeMutablePointer<UInt32>? {
        ComputeMD5(UnsafeMutablePointer(mutating: data), Int32(size))
    }
    
    public static func sha1(_ data: UnsafePointer<UInt8>, size: Int) -> UnsafeMutablePointer<UInt32>? {
        ComputeSHA1(UnsafeMutablePointer(mutating: data), Int32(size))
    }
    
    public static func sha256(_ data: UnsafePointer<UInt8>, size: Int) -> UnsafeMutablePointer<UInt32>? {
        ComputeSHA256(UnsafeMutablePointer(mutating: data), Int32(size))
    }
}
