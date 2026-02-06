import CRaylib

public enum Memory {
    public static func alloc(_ size: Int) -> UnsafeMutableRawPointer? { MemAlloc(UInt32(size)) }
    public static func realloc(_ pointer: UnsafeMutableRawPointer?, size: Int) -> UnsafeMutableRawPointer? {
        MemRealloc(pointer, UInt32(size))
    }
    public static func free(_ pointer: UnsafeMutableRawPointer?) { MemFree(pointer) }
}
