import Foundation

#if os(macOS)
import SwiftUI
import AppKit
import CoreGraphics

public struct RaylibView: NSViewRepresentable {
    public let renderer: App.Renderer

    public init(renderer: App.Renderer) {
        self.renderer = renderer
    }

    public func makeNSView(context: Context) -> RaylibHostView {
        RaylibHostView(renderer: renderer)
    }

    public func updateNSView(_ nsView: RaylibHostView, context: Context) {
        nsView.updateRenderer(renderer)
    }
}

public final class RaylibHostView: NSView {
    private var renderer: App.Renderer
    private var timer: Timer?

    public init(renderer: App.Renderer) {
        self.renderer = renderer
        super.init(frame: .zero)
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    public override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        if window == nil {
            stop()
            renderer.shutdown()
        } else {
            start()
        }
    }

    public func updateRenderer(_ renderer: App.Renderer) {
        self.renderer = renderer
    }

    private func start() {
        if timer != nil {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            if !self.renderer.step() {
                self.stop()
            }
        }
    }

    private func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        stop()
        renderer.shutdown()
    }
}

public struct RaylibImageView: NSViewRepresentable {
    public let renderer: App.Renderer

    public init(renderer: App.Renderer) {
        self.renderer = renderer
    }

    public func makeNSView(context: Context) -> RaylibImageHostView {
        RaylibImageHostView(renderer: renderer)
    }

    public func updateNSView(_ nsView: RaylibImageHostView, context: Context) {
        nsView.updateRenderer(renderer)
    }
}

public final class RaylibImageHostView: NSView {
    private var renderer: App.Renderer
    private var timer: Timer?
    private var currentImage: CGImage?

    public init(renderer: App.Renderer) {
        self.renderer = renderer
        super.init(frame: .zero)
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    public override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        if window == nil {
            stop()
            renderer.shutdown()
        } else {
            start()
        }
    }

    public override func draw(_ dirtyRect: NSRect) {
        guard let image = currentImage else { return }
        NSGraphicsContext.current?.cgContext.draw(image, in: bounds)
    }

    public func updateRenderer(_ renderer: App.Renderer) {
        self.renderer = renderer
    }

    private func start() {
        if timer != nil {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            if !self.renderer.step() {
                self.stop()
                return
            }
            self.captureFrame()
        }
    }

    private func captureFrame() {
        var image: CRaylib.Image = Texture.loadImageFromScreen()
        if image.data == nil {
            Texture.unloadImage(image)
            return
        }
        Texture.imageFormat(&image, newFormat: Int(PIXELFORMAT_UNCOMPRESSED_R8G8B8A8.rawValue))
        currentImage = makeCGImage(from: image)
        Texture.unloadImage(image)
        setNeedsDisplay(bounds)
    }

    private func makeCGImage(from image: CRaylib.Image) -> CGImage? {
        guard let data = image.data else { return nil }
        let width = Int(image.width)
        let height = Int(image.height)
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        let dataSize = bytesPerRow * height
        let buffer = Data(bytes: data, count: dataSize)
        guard let provider = CGDataProvider(data: buffer as CFData) else { return nil }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        return CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo,
            provider: provider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
    }

    private func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        stop()
        renderer.shutdown()
    }
}
#endif
