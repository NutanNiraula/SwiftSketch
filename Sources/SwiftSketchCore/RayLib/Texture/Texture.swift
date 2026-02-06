#if SS_MINIMAL || SS_NO_TEXTURES
public enum Texture {}
#else
import CRaylib

public enum Texture {
    public static func loadImage(_ fileName: String) -> Image {
        fileName.withCString { LoadImage($0) }
    }
    
    public static func loadImageRaw(
        _ fileName: String,
        width: Int,
        height: Int,
        format: Int,
        headerSize: Int
    ) -> Image {
        fileName.withCString { LoadImageRaw($0, Int32(width), Int32(height), Int32(format), Int32(headerSize)) }
    }
    
    public static func loadImageAnim(
        _ fileName: String,
        frames: UnsafeMutablePointer<Int32>? = nil
    ) -> Image {
        fileName.withCString { LoadImageAnim($0, frames) }
    }
    
    public static func loadImageAnimFromMemory(
        _ fileType: String,
        data: UnsafePointer<UInt8>,
        dataSize: Int,
        frames: UnsafeMutablePointer<Int32>? = nil
    ) -> Image {
        fileType.withCString { LoadImageAnimFromMemory($0, data, Int32(dataSize), frames) }
    }
    
    public static func loadImageFromMemory(
        _ fileType: String,
        data: UnsafePointer<UInt8>,
        dataSize: Int
    ) -> Image {
        fileType.withCString { LoadImageFromMemory($0, data, Int32(dataSize)) }
    }
    
    public static func loadImageFromTexture(_ texture: Texture2D) -> Image {
        LoadImageFromTexture(texture)
    }
    
    public static func loadImageFromScreen() -> Image {
        LoadImageFromScreen()
    }
    
    public static func isImageValid(_ image: Image) -> Bool {
        IsImageValid(image)
    }
    
    public static func unloadImage(_ image: Image) {
        UnloadImage(image)
    }
    
    public static func exportImage(_ image: Image, fileName: String) -> Bool {
        fileName.withCString { ExportImage(image, $0) }
    }
    
    public static func exportImageToMemory(
        _ image: Image,
        fileType: String,
        fileSize: UnsafeMutablePointer<Int32>? = nil
    ) -> UnsafeMutablePointer<UInt8>? {
        fileType.withCString { ExportImageToMemory(image, $0, fileSize) }
    }
    
    public static func exportImageAsCode(_ image: Image, fileName: String) -> Bool {
        fileName.withCString { ExportImageAsCode(image, $0) }
    }
    
    public static func genImageColor(width: Int, height: Int, color: Color) -> Image {
        GenImageColor(Int32(width), Int32(height), color)
    }
    
    public static func genImageGradientLinear(
        width: Int,
        height: Int,
        direction: Int,
        start: Color,
        end: Color
    ) -> Image {
        GenImageGradientLinear(Int32(width), Int32(height), Int32(direction), start, end)
    }
    
    public static func genImageGradientRadial(
        width: Int,
        height: Int,
        density: Double,
        inner: Color,
        outer: Color
    ) -> Image {
        GenImageGradientRadial(Int32(width), Int32(height), Float(density), inner, outer)
    }
    
    public static func genImageGradientSquare(
        width: Int,
        height: Int,
        density: Double,
        inner: Color,
        outer: Color
    ) -> Image {
        GenImageGradientSquare(Int32(width), Int32(height), Float(density), inner, outer)
    }
    
    public static func genImageChecked(
        width: Int,
        height: Int,
        checksX: Int,
        checksY: Int,
        color1: Color,
        color2: Color
    ) -> Image {
        GenImageChecked(Int32(width), Int32(height), Int32(checksX), Int32(checksY), color1, color2)
    }
    
    public static func genImageWhiteNoise(width: Int, height: Int, factor: Double) -> Image {
        GenImageWhiteNoise(Int32(width), Int32(height), Float(factor))
    }
    
    public static func genImagePerlinNoise(
        width: Int,
        height: Int,
        offsetX: Int,
        offsetY: Int,
        scale: Double
    ) -> Image {
        GenImagePerlinNoise(Int32(width), Int32(height), Int32(offsetX), Int32(offsetY), Float(scale))
    }
    
    public static func genImageCellular(
        width: Int,
        height: Int,
        tileSize: Int
    ) -> Image {
        GenImageCellular(Int32(width), Int32(height), Int32(tileSize))
    }
    
    public static func genImageText(
        width: Int,
        height: Int,
        text: String
    ) -> Image {
        text.withCString { GenImageText(Int32(width), Int32(height), $0) }
    }
    
    public static func imageCopy(_ image: Image) -> Image {
        ImageCopy(image)
    }
    
    public static func imageFromImage(_ image: Image, rec: Rectangle) -> Image {
        ImageFromImage(image, rec)
    }
    
    public static func imageFromChannel(_ image: Image, selectedChannel: Int) -> Image {
        ImageFromChannel(image, Int32(selectedChannel))
    }
    
    public static func imageText(_ text: String, fontSize: Int, color: Color) -> Image {
        text.withCString { ImageText($0, Int32(fontSize), color) }
    }
    
    public static func imageTextEx(
        _ font: Font,
        text: String,
        fontSize: Double,
        spacing: Double,
        tint: Color
    ) -> Image {
        text.withCString { ImageTextEx(font, $0, Float(fontSize), Float(spacing), tint) }
    }
    
    public static func imageFormat(_ image: inout Image, newFormat: Int) {
        withUnsafeMutablePointer(to: &image) { ImageFormat($0, Int32(newFormat)) }
    }
    
    public static func imageToPOT(_ image: inout Image, fill: Color) {
        withUnsafeMutablePointer(to: &image) { ImageToPOT($0, fill) }
    }
    
    public static func imageCrop(_ image: inout Image, crop: Rectangle) {
        withUnsafeMutablePointer(to: &image) { ImageCrop($0, crop) }
    }
    
    public static func imageAlphaCrop(_ image: inout Image, threshold: Double) {
        withUnsafeMutablePointer(to: &image) { ImageAlphaCrop($0, Float(threshold)) }
    }
    
    public static func imageAlphaClear(_ image: inout Image, color: Color, threshold: Double) {
        withUnsafeMutablePointer(to: &image) { ImageAlphaClear($0, color, Float(threshold)) }
    }
    
    public static func imageAlphaMask(_ image: inout Image, alphaMask: Image) {
        withUnsafeMutablePointer(to: &image) { ImageAlphaMask($0, alphaMask) }
    }
    
    public static func imageAlphaPremultiply(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageAlphaPremultiply($0) }
    }
    
    public static func imageBlurGaussian(_ image: inout Image, blurSize: Int) {
        withUnsafeMutablePointer(to: &image) { ImageBlurGaussian($0, Int32(blurSize)) }
    }
    
    public static func imageKernelConvolution(
        _ image: inout Image,
        kernel: [Float],
        kernelSize: Int
    ) {
        guard !kernel.isEmpty else { return }
        withUnsafeMutablePointer(to: &image) { imagePtr in
            kernel.withUnsafeBufferPointer { buffer in
                guard let base = buffer.baseAddress else { return }
                ImageKernelConvolution(imagePtr, base, Int32(kernelSize))
            }
        }
    }
    
    public static func imageResize(_ image: inout Image, newWidth: Int, newHeight: Int) {
        withUnsafeMutablePointer(to: &image) { ImageResize($0, Int32(newWidth), Int32(newHeight)) }
    }
    
    public static func imageResizeNN(_ image: inout Image, newWidth: Int, newHeight: Int) {
        withUnsafeMutablePointer(to: &image) { ImageResizeNN($0, Int32(newWidth), Int32(newHeight)) }
    }
    
    public static func imageResizeCanvas(
        _ image: inout Image,
        newWidth: Int,
        newHeight: Int,
        offsetX: Int,
        offsetY: Int,
        fill: Color
    ) {
        withUnsafeMutablePointer(to: &image) {
            ImageResizeCanvas($0, Int32(newWidth), Int32(newHeight), Int32(offsetX), Int32(offsetY), fill)
        }
    }
    
    public static func imageMipmaps(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageMipmaps($0) }
    }
    
    public static func imageDither(
        _ image: inout Image,
        rBpp: Int,
        gBpp: Int,
        bBpp: Int,
        aBpp: Int
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDither($0, Int32(rBpp), Int32(gBpp), Int32(bBpp), Int32(aBpp)) }
    }
    
    public static func imageFlipVertical(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageFlipVertical($0) }
    }
    
    public static func imageFlipHorizontal(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageFlipHorizontal($0) }
    }
    
    public static func imageRotate(_ image: inout Image, degrees: Int) {
        withUnsafeMutablePointer(to: &image) { ImageRotate($0, Int32(degrees)) }
    }
    
    public static func imageRotateCW(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageRotateCW($0) }
    }
    
    public static func imageRotateCCW(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageRotateCCW($0) }
    }
    
    public static func imageColorTint(_ image: inout Image, color: Color) {
        withUnsafeMutablePointer(to: &image) { ImageColorTint($0, color) }
    }
    
    public static func imageColorInvert(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageColorInvert($0) }
    }
    
    public static func imageColorGrayscale(_ image: inout Image) {
        withUnsafeMutablePointer(to: &image) { ImageColorGrayscale($0) }
    }
    
    public static func imageColorContrast(_ image: inout Image, contrast: Double) {
        withUnsafeMutablePointer(to: &image) { ImageColorContrast($0, Float(contrast)) }
    }
    
    public static func imageColorBrightness(_ image: inout Image, brightness: Int) {
        withUnsafeMutablePointer(to: &image) { ImageColorBrightness($0, Int32(brightness)) }
    }
    
    public static func imageColorReplace(_ image: inout Image, color: Color, replace: Color) {
        withUnsafeMutablePointer(to: &image) { ImageColorReplace($0, color, replace) }
    }
    
    public static func loadImageColors(_ image: Image) -> UnsafeMutablePointer<Color>? {
        LoadImageColors(image)
    }
    
    public static func loadImagePalette(
        _ image: Image,
        maxPaletteSize: Int,
        colorCount: UnsafeMutablePointer<Int32>? = nil
    ) -> UnsafeMutablePointer<Color>? {
        LoadImagePalette(image, Int32(maxPaletteSize), colorCount)
    }
    
    public static func unloadImageColors(_ colors: UnsafeMutablePointer<Color>?) {
        UnloadImageColors(colors)
    }
    
    public static func unloadImagePalette(_ colors: UnsafeMutablePointer<Color>?) {
        UnloadImagePalette(colors)
    }
    
    public static func getImageAlphaBorder(_ image: Image, threshold: Double) -> Rectangle {
        GetImageAlphaBorder(image, Float(threshold))
    }
    
    public static func getImageColor(_ image: Image, x: Int, y: Int) -> Color {
        GetImageColor(image, Int32(x), Int32(y))
    }
    
    public static func imageClearBackground(_ image: inout Image, color: Color) {
        withUnsafeMutablePointer(to: &image) { ImageClearBackground($0, color) }
    }
    
    public static func imageDrawPixel(_ image: inout Image, posX: Int, posY: Int, color: Color) {
        withUnsafeMutablePointer(to: &image) { ImageDrawPixel($0, Int32(posX), Int32(posY), color) }
    }
    
    public static func imageDrawPixelV(_ image: inout Image, position: Vector2, color: Color) {
        withUnsafeMutablePointer(to: &image) { ImageDrawPixelV($0, position, color) }
    }
    
    public static func imageDrawLine(
        _ image: inout Image,
        startPosX: Int,
        startPosY: Int,
        endPosX: Int,
        endPosY: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) {
            ImageDrawLine($0, Int32(startPosX), Int32(startPosY), Int32(endPosX), Int32(endPosY), color)
        }
    }
    
    public static func imageDrawLineV(_ image: inout Image, start: Vector2, end: Vector2, color: Color) {
        withUnsafeMutablePointer(to: &image) { ImageDrawLineV($0, start, end, color) }
    }
    
    public static func imageDrawLineEx(
        _ image: inout Image,
        start: Vector2,
        end: Vector2,
        thick: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawLineEx($0, start, end, Int32(thick), color) }
    }
    
    public static func imageDrawCircle(
        _ image: inout Image,
        centerX: Int,
        centerY: Int,
        radius: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawCircle($0, Int32(centerX), Int32(centerY), Int32(radius), color) }
    }
    
    public static func imageDrawCircleV(_ image: inout Image, center: Vector2, radius: Int, color: Color) {
        withUnsafeMutablePointer(to: &image) { ImageDrawCircleV($0, center, Int32(radius), color) }
    }
    
    public static func imageDrawCircleLines(
        _ image: inout Image,
        centerX: Int,
        centerY: Int,
        radius: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) {
            ImageDrawCircleLines($0, Int32(centerX), Int32(centerY), Int32(radius), color)
        }
    }
    
    public static func imageDrawCircleLinesV(
        _ image: inout Image,
        center: Vector2,
        radius: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawCircleLinesV($0, center, Int32(radius), color) }
    }
    
    public static func imageDrawRectangle(
        _ image: inout Image,
        posX: Int,
        posY: Int,
        width: Int,
        height: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) {
            ImageDrawRectangle($0, Int32(posX), Int32(posY), Int32(width), Int32(height), color)
        }
    }
    
    public static func imageDrawRectangleV(
        _ image: inout Image,
        position: Vector2,
        size: Vector2,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawRectangleV($0, position, size, color) }
    }
    
    public static func imageDrawRectangleRec(_ image: inout Image, rec: Rectangle, color: Color) {
        withUnsafeMutablePointer(to: &image) { ImageDrawRectangleRec($0, rec, color) }
    }
    
    public static func imageDrawRectangleLines(
        _ image: inout Image,
        rec: Rectangle,
        thick: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawRectangleLines($0, rec, Int32(thick), color) }
    }
    
    public static func imageDrawTriangle(
        _ image: inout Image,
        v1: Vector2,
        v2: Vector2,
        v3: Vector2,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawTriangle($0, v1, v2, v3, color) }
    }
    
    public static func imageDrawTriangleEx(
        _ image: inout Image,
        v1: Vector2,
        v2: Vector2,
        v3: Vector2,
        c1: Color,
        c2: Color,
        c3: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawTriangleEx($0, v1, v2, v3, c1, c2, c3) }
    }
    
    public static func imageDrawTriangleLines(
        _ image: inout Image,
        v1: Vector2,
        v2: Vector2,
        v3: Vector2,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDrawTriangleLines($0, v1, v2, v3, color) }
    }
    
    public static func imageDrawTriangleFan(_ image: inout Image, points: [Vector2], color: Color) {
        guard !points.isEmpty else { return }
        withUnsafeMutablePointer(to: &image) { imagePtr in
            points.withUnsafeBufferPointer { buffer in
                guard let base = buffer.baseAddress else { return }
                ImageDrawTriangleFan(imagePtr, base, Int32(buffer.count), color)
            }
        }
    }
    
    public static func imageDrawTriangleStrip(_ image: inout Image, points: [Vector2], color: Color) {
        guard !points.isEmpty else { return }
        withUnsafeMutablePointer(to: &image) { imagePtr in
            points.withUnsafeBufferPointer { buffer in
                guard let base = buffer.baseAddress else { return }
                ImageDrawTriangleStrip(imagePtr, base, Int32(buffer.count), color)
            }
        }
    }
    
    public static func imageDraw(
        _ image: inout Image,
        src: Image,
        srcRec: Rectangle,
        dstRec: Rectangle,
        tint: Color
    ) {
        withUnsafeMutablePointer(to: &image) { ImageDraw($0, src, srcRec, dstRec, tint) }
    }
    
    public static func imageDrawText(
        _ image: inout Image,
        text: String,
        posX: Int,
        posY: Int,
        fontSize: Int,
        color: Color
    ) {
        withUnsafeMutablePointer(to: &image) { imagePtr in
            text.withCString { ImageDrawText(imagePtr, $0, Int32(posX), Int32(posY), Int32(fontSize), color) }
        }
    }
    
    public static func imageDrawTextEx(
        _ image: inout Image,
        font: Font,
        text: String,
        position: Vector2,
        fontSize: Double,
        spacing: Double,
        tint: Color
    ) {
        withUnsafeMutablePointer(to: &image) { imagePtr in
            text.withCString {
                ImageDrawTextEx(imagePtr, font, $0, position, Float(fontSize), Float(spacing), tint)
            }
        }
    }
    
    public static func loadTexture(_ fileName: String) -> Texture2D {
        fileName.withCString { LoadTexture($0) }
    }
    
    public static func loadTextureFromImage(_ image: Image) -> Texture2D {
        LoadTextureFromImage(image)
    }
    
    public static func loadTextureCubemap(_ image: Image, layout: Int) -> TextureCubemap {
        LoadTextureCubemap(image, Int32(layout))
    }
    
    public static func loadRenderTexture(width: Int, height: Int) -> RenderTexture2D {
        LoadRenderTexture(Int32(width), Int32(height))
    }
    
    public static func isTextureValid(_ texture: Texture2D) -> Bool {
        IsTextureValid(texture)
    }
    
    public static func unloadTexture(_ texture: Texture2D) {
        UnloadTexture(texture)
    }
    
    public static func isRenderTextureValid(_ target: RenderTexture2D) -> Bool {
        IsRenderTextureValid(target)
    }
    
    public static func unloadRenderTexture(_ target: RenderTexture2D) {
        UnloadRenderTexture(target)
    }
    
    public static func updateTexture(_ texture: Texture2D, pixels: UnsafeRawPointer) {
        UpdateTexture(texture, pixels)
    }
    
    public static func updateTextureRec(_ texture: Texture2D, rec: Rectangle, pixels: UnsafeRawPointer) {
        UpdateTextureRec(texture, rec, pixels)
    }
    
    public static func genTextureMipmaps(_ texture: inout Texture2D) {
        withUnsafeMutablePointer(to: &texture) { GenTextureMipmaps($0) }
    }
    
    public static func setTextureFilter(_ texture: Texture2D, filter: Int) {
        SetTextureFilter(texture, Int32(filter))
    }
    
    public static func setTextureWrap(_ texture: Texture2D, wrap: Int) {
        SetTextureWrap(texture, Int32(wrap))
    }

    public static func setShapesTexture(_ texture: Texture2D, source: Rectangle) {
        SetShapesTexture(texture, source)
    }

    public static func getShapesTexture() -> Texture2D {
        GetShapesTexture()
    }

    public static func getShapesTextureRectangle() -> Rectangle {
        GetShapesTextureRectangle()
    }
    
    public static func drawTexture(_ texture: Texture2D, posX: Int, posY: Int, tint: Color) {
        DrawTexture(texture, Int32(posX), Int32(posY), tint)
    }
    
    public static func drawTextureV(_ texture: Texture2D, position: Vector2, tint: Color) {
        DrawTextureV(texture, position, tint)
    }
    
    public static func drawTextureEx(
        _ texture: Texture2D,
        position: Vector2,
        rotation: Double,
        scale: Double,
        tint: Color
    ) {
        DrawTextureEx(texture, position, Float(rotation), Float(scale), tint)
    }
    
    public static func drawTextureRec(
        _ texture: Texture2D,
        source: Rectangle,
        position: Vector2,
        tint: Color
    ) {
        DrawTextureRec(texture, source, position, tint)
    }
    
    public static func drawTexturePro(
        _ texture: Texture2D,
        source: Rectangle,
        dest: Rectangle,
        origin: Vector2,
        rotation: Double,
        tint: Color
    ) {
        DrawTexturePro(texture, source, dest, origin, Float(rotation), tint)
    }
    
    public static func drawTextureNPatch(
        _ texture: Texture2D,
        nPatchInfo: NPatchInfo,
        dest: Rectangle,
        origin: Vector2,
        rotation: Double,
        tint: Color
    ) {
        DrawTextureNPatch(texture, nPatchInfo, dest, origin, Float(rotation), tint)
    }
    
    public static func colorIsEqual(_ color1: Color, _ color2: Color) -> Bool {
        ColorIsEqual(color1, color2)
    }
    
    public static func fade(_ color: Color, alpha: Double) -> Color {
        Fade(color, Float(alpha))
    }
    
    public static func colorToInt(_ color: Color) -> Int {
        Int(ColorToInt(color))
    }
    
    public static func colorNormalize(_ color: Color) -> Vector4 {
        ColorNormalize(color)
    }
    
    public static func colorFromNormalized(_ normalized: Vector4) -> Color {
        ColorFromNormalized(normalized)
    }
    
    public static func colorToHSV(_ color: Color) -> Vector3 {
        ColorToHSV(color)
    }
    
    public static func colorFromHSV(hue: Double, saturation: Double, value: Double) -> Color {
        ColorFromHSV(Float(hue), Float(saturation), Float(value))
    }
    
    public static func colorTint(_ color: Color, tint: Color) -> Color {
        ColorTint(color, tint)
    }
    
    public static func colorBrightness(_ color: Color, factor: Double) -> Color {
        ColorBrightness(color, Float(factor))
    }
    
    public static func colorContrast(_ color: Color, contrast: Double) -> Color {
        ColorContrast(color, Float(contrast))
    }
    
    public static func colorAlpha(_ color: Color, alpha: Double) -> Color {
        ColorAlpha(color, Float(alpha))
    }
    
    public static func colorAlphaBlend(_ dst: Color, _ src: Color, _ tint: Color) -> Color {
        ColorAlphaBlend(dst, src, tint)
    }
    
    public static func colorLerp(_ color1: Color, _ color2: Color, factor: Double) -> Color {
        ColorLerp(color1, color2, Float(factor))
    }
    
    public static func getColor(_ hexValue: UInt32) -> Color {
        GetColor(hexValue)
    }
    
    public static func getPixelColor(_ srcPtr: UnsafeRawPointer, format: Int) -> Color {
        GetPixelColor(UnsafeMutableRawPointer(mutating: srcPtr), Int32(format))
    }
    
    public static func setPixelColor(_ dstPtr: UnsafeMutableRawPointer, color: Color, format: Int) {
        SetPixelColor(dstPtr, color, Int32(format))
    }
    
    public static func getPixelDataSize(width: Int, height: Int, format: Int) -> Int {
        Int(GetPixelDataSize(Int32(width), Int32(height), Int32(format)))
    }
}
#endif
