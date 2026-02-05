
import Foundation
import CRaylib

public enum Text {
    public static func getFontDefault() -> Font {
        GetFontDefault()
    }
    
    public static func loadFont(_ fileName: String) -> Font {
        fileName.withCString { LoadFont($0) }
    }
    
    public static func loadFontEx(_ fileName: String, size: Int, codepoints: [Int32]? = nil) -> Font {
        fileName.withCString { namePtr in
            guard let codepoints, !codepoints.isEmpty else {
                return LoadFontEx(namePtr, Int32(size), nil, 0)
            }
            return codepoints.withUnsafeBufferPointer { buffer in
                LoadFontEx(namePtr, Int32(size), buffer.baseAddress, Int32(buffer.count))
            }
        }
    }
    
    public static func loadFontFromImage(_ image: Image, key: Color, firstChar: Int) -> Font {
        LoadFontFromImage(image, key, Int32(firstChar))
    }
    
    public static func loadFontFromMemory(
        _ fileType: String,
        data: UnsafePointer<UInt8>,
        dataSize: Int,
        size: Int,
        codepoints: [Int32]? = nil
    ) -> Font {
        fileType.withCString { typePtr in
            guard let codepoints, !codepoints.isEmpty else {
                return LoadFontFromMemory(typePtr, data, Int32(dataSize), Int32(size), nil, 0)
            }
            return codepoints.withUnsafeBufferPointer { buffer in
                LoadFontFromMemory(typePtr, data, Int32(dataSize), Int32(size), buffer.baseAddress, Int32(buffer.count))
            }
        }
    }
    
    public static func isFontValid(_ font: Font) -> Bool {
        IsFontValid(font)
    }
    
    public static func loadFontData(
        _ data: UnsafePointer<UInt8>,
        dataSize: Int,
        size: Int,
        codepoints: [Int32]? = nil,
        type: Int,
        glyphCount: UnsafeMutablePointer<Int32>? = nil
    ) -> UnsafeMutablePointer<GlyphInfo>? {
        guard let codepoints, !codepoints.isEmpty else {
            return LoadFontData(data, Int32(dataSize), Int32(size), nil, 0, Int32(type), glyphCount)
        }
        return codepoints.withUnsafeBufferPointer { buffer in
            LoadFontData(data, Int32(dataSize), Int32(size), buffer.baseAddress, Int32(buffer.count), Int32(type), glyphCount)
        }
    }
    
    public static func genImageFontAtlas(
        _ glyphs: UnsafePointer<GlyphInfo>,
        glyphRecs: UnsafeMutablePointer<UnsafeMutablePointer<Rectangle>?>?,
        glyphCount: Int,
        fontSize: Int,
        padding: Int,
        packMethod: Int
    ) -> Image {
        GenImageFontAtlas(glyphs, glyphRecs, Int32(glyphCount), Int32(fontSize), Int32(padding), Int32(packMethod))
    }
    
    public static func unloadFontData(_ glyphs: UnsafeMutablePointer<GlyphInfo>?, count: Int) {
        UnloadFontData(glyphs, Int32(count))
    }
    
    public static func unloadFont(_ font: Font) {
        UnloadFont(font)
    }
    
    public static func exportFontAsCode(_ font: Font, fileName: String) -> Bool {
        fileName.withCString { ExportFontAsCode(font, $0) }
    }
    
    public static func drawText(_ text: String, x: Int, y: Int, size: Int, color: Color) {
        text.withCString { DrawText($0, Int32(x), Int32(y), Int32(size), color) }
    }
    
    public static func drawTextEx(
        _ font: Font,
        text: String,
        position: Vector2,
        size: Double,
        spacing: Double,
        color: Color
    ) {
        text.withCString { DrawTextEx(font, $0, position, Float(size), Float(spacing), color) }
    }
    
    public static func drawTextPro(
        _ font: Font,
        text: String,
        position: Vector2,
        origin: Vector2,
        rotation: Double,
        size: Double,
        spacing: Double,
        color: Color
    ) {
        text.withCString {
            DrawTextPro(font, $0, position, origin, Float(rotation), Float(size), Float(spacing), color)
        }
    }
    
    public static func drawTextCodepoint(
        _ font: Font,
        codepoint: Int,
        position: Vector2,
        size: Double,
        color: Color
    ) {
        DrawTextCodepoint(font, Int32(codepoint), position, Float(size), color)
    }
    
    public static func drawTextCodepoints(
        _ font: Font,
        codepoints: [Int32],
        position: Vector2,
        size: Double,
        spacing: Double,
        color: Color
    ) {
        guard !codepoints.isEmpty else { return }
        codepoints.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            DrawTextCodepoints(font, base, Int32(buffer.count), position, Float(size), Float(spacing), color)
        }
    }
    
    public static func setTextLineSpacing(_ spacing: Int) {
        SetTextLineSpacing(Int32(spacing))
    }
    
    public static func measureText(_ text: String, size: Int) -> Int {
        text.withCString { Int(MeasureText($0, Int32(size))) }
    }
    
    public static func measureTextEx(
        _ font: Font,
        text: String,
        size: Double,
        spacing: Double
    ) -> Vector2 {
        text.withCString { MeasureTextEx(font, $0, Float(size), Float(spacing)) }
    }
    
    public static func getGlyphIndex(_ font: Font, codepoint: Int) -> Int {
        Int(GetGlyphIndex(font, Int32(codepoint)))
    }
    
    public static func getGlyphInfo(_ font: Font, codepoint: Int) -> GlyphInfo {
        GetGlyphInfo(font, Int32(codepoint))
    }
    
    public static func getGlyphAtlasRec(_ font: Font, codepoint: Int) -> Rectangle {
        GetGlyphAtlasRec(font, Int32(codepoint))
    }
    
    public static func loadUTF8(_ codepoints: UnsafePointer<Int32>, length: Int) -> UnsafeMutablePointer<CChar>? {
        LoadUTF8(codepoints, Int32(length))
    }
    
    public static func loadUTF8(_ codepoints: [Int32]) -> UnsafeMutablePointer<CChar>? {
        guard !codepoints.isEmpty else { return nil }
        return codepoints.withUnsafeBufferPointer { buffer in
            LoadUTF8(buffer.baseAddress, Int32(buffer.count))
        }
    }
    
    public static func unloadUTF8(_ text: UnsafeMutablePointer<CChar>?) {
        UnloadUTF8(text)
    }
    
    public static func loadCodepoints(_ text: String, count: UnsafeMutablePointer<Int32>? = nil) -> UnsafeMutablePointer<Int32>? {
        text.withCString { LoadCodepoints($0, count) }
    }
    
    public static func unloadCodepoints(_ codepoints: UnsafeMutablePointer<Int32>?) {
        UnloadCodepoints(codepoints)
    }
    
    public static func getCodepointCount(_ text: String) -> Int {
        text.withCString { Int(GetCodepointCount($0)) }
    }
    
    public static func getCodepoint(_ text: String, codepointSize: UnsafeMutablePointer<Int32>? = nil) -> Int {
        text.withCString { Int(GetCodepoint($0, codepointSize)) }
    }
    
    public static func getCodepointNext(_ text: String, codepointSize: UnsafeMutablePointer<Int32>? = nil) -> Int {
        text.withCString { Int(GetCodepointNext($0, codepointSize)) }
    }
    
    public static func getCodepointPrevious(_ text: String, codepointSize: UnsafeMutablePointer<Int32>? = nil) -> Int {
        text.withCString { Int(GetCodepointPrevious($0, codepointSize)) }
    }
    
    public static func codepointToUTF8(_ codepoint: Int, utf8Size: UnsafeMutablePointer<Int32>? = nil) -> String {
        guard let result = CodepointToUTF8(Int32(codepoint), utf8Size) else { return "" }
        return String(cString: result)
    }
    
    public static func loadTextLines(_ text: String, count: UnsafeMutablePointer<Int32>? = nil) -> UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>? {
        text.withCString { LoadTextLines($0, count) }
    }
    
    public static func unloadTextLines(_ lines: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?, count: Int) {
        UnloadTextLines(lines, Int32(count))
    }
    
    public static func textCopy(_ destination: UnsafeMutablePointer<CChar>, source: String) -> Int {
        source.withCString { Int(TextCopy(destination, $0)) }
    }
    
    public static func textIsEqual(_ text1: String, _ text2: String) -> Bool {
        text1.withCString { text1Ptr in
            text2.withCString { text2Ptr in
                TextIsEqual(text1Ptr, text2Ptr)
            }
        }
    }
    
    public static func textLength(_ text: String) -> Int {
        text.withCString { Int(TextLength($0)) }
    }
    
    public static func textSubtext(_ text: String, position: Int, length: Int) -> String {
        text.withCString { ptr in
            guard let result = TextSubtext(ptr, Int32(position), Int32(length)) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func textRemoveSpaces(_ text: String) -> String {
        text.withCString { ptr in
            guard let result = TextRemoveSpaces(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func getTextBetween(_ text: String, begin: String, end: String) -> String {
        text.withCString { textPtr in
            begin.withCString { beginPtr in
                end.withCString { endPtr in
                    guard let result = GetTextBetween(textPtr, beginPtr, endPtr) else { return "" }
                    let value = String(cString: result)
                    MemFree(result)
                    return value
                }
            }
        }
    }
    
    public static func textReplace(_ text: String, search: String, replacement: String) -> String {
        text.withCString { textPtr in
            search.withCString { searchPtr in
                replacement.withCString { replacementPtr in
                    guard let result = TextReplace(textPtr, searchPtr, replacementPtr) else { return "" }
                    let value = String(cString: result)
                    MemFree(result)
                    return value
                }
            }
        }
    }
    
    public static func textReplaceBetween(_ text: String, begin: String, end: String, replacement: String) -> String {
        text.withCString { textPtr in
            begin.withCString { beginPtr in
                end.withCString { endPtr in
                    replacement.withCString { replacementPtr in
                        guard let result = TextReplaceBetween(textPtr, beginPtr, endPtr, replacementPtr) else { return "" }
                        let value = String(cString: result)
                        MemFree(result)
                        return value
                    }
                }
            }
        }
    }
    
    public static func textInsert(_ text: String, insert: String, position: Int) -> String {
        text.withCString { textPtr in
            insert.withCString { insertPtr in
                guard let result = TextInsert(textPtr, insertPtr, Int32(position)) else { return "" }
                let value = String(cString: result)
                MemFree(result)
                return value
            }
        }
    }
    
    public static func textJoin(_ list: [String], delimiter: String) -> String {
        if list.isEmpty { return "" }
        let cStrings = list.map { strdup($0) }
        defer { cStrings.forEach { free($0) } }
        return delimiter.withCString { delimiterPtr in
            var mutable = cStrings
            return mutable.withUnsafeMutableBufferPointer { buffer in
                guard let base = buffer.baseAddress else { return "" }
                guard let joined = TextJoin(base, Int32(buffer.count), delimiterPtr) else { return "" }
                return String(cString: joined)
            }
        }
    }
    
    public static func textSplit(_ text: String, delimiter: Character) -> [String] {
        let delimiterByte = String(delimiter).utf8.first ?? 0
        let delimiterChar = CChar(bitPattern: delimiterByte)
        var count: Int32 = 0
        return text.withCString { textPtr in
            guard let list = TextSplit(textPtr, delimiterChar, &count) else { return [] }
            var result: [String] = []
            result.reserveCapacity(Int(count))
            for index in 0..<Int(count) {
                if let item = list[index] {
                    result.append(String(cString: item))
                }
            }
            return result
        }
    }
    
    public static func textAppend(_ text: UnsafeMutablePointer<CChar>, append: String, position: UnsafeMutablePointer<Int32>) {
        append.withCString { TextAppend(text, $0, position) }
    }
    
    public static func textFindIndex(_ text: String, search: String) -> Int {
        text.withCString { textPtr in
            search.withCString { searchPtr in
                Int(TextFindIndex(textPtr, searchPtr))
            }
        }
    }
    
    public static func textToUpper(_ text: String) -> String {
        text.withCString { ptr in
            guard let result = TextToUpper(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func textToLower(_ text: String) -> String {
        text.withCString { ptr in
            guard let result = TextToLower(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func textToPascal(_ text: String) -> String {
        text.withCString { ptr in
            guard let result = TextToPascal(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func textToSnake(_ text: String) -> String {
        text.withCString { ptr in
            guard let result = TextToSnake(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func textToCamel(_ text: String) -> String {
        text.withCString { ptr in
            guard let result = TextToCamel(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func textToInteger(_ text: String) -> Int {
        text.withCString { Int(TextToInteger($0)) }
    }
    
    public static func textToFloat(_ text: String) -> Double {
        text.withCString { Double(TextToFloat($0)) }
    }
    
    public static func draw(_ text: String, x: Int, y: Int, size: Int = 18, color: Color? = nil) {
        guard let fillColor = color ?? Render.fillColor else { return }
        DrawText(text, Int32(x), Int32(y), Int32(size), fillColor)
    }
    
    public static func draw(_ text: String, xy: Vector2, size: Int = 18, color: Color? = nil) {
        guard let fillColor = color ?? Render.fillColor else { return }
        DrawText(text, Int32(xy.x), Int32(xy.y), Int32(size), fillColor)
    }
    
    public static func measure(_ text: String, size: Int = 18) -> Int {
        Int(MeasureText(text, Int32(size)))
    }
}
