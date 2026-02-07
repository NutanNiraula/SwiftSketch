import Foundation

#if canImport(SwiftUI)
import SwiftUI

public struct SwiftUIRaylibDemoView: SwiftUI.View {
    private enum InitState {
        case idle
        case running
    }

    private final class ViewModel: ObservableObject {
        var x: Double = 0
        var speed: Double = 2
        let width: Int = 800
        let height: Int = 600
        private var initState: InitState = .idle

        lazy var renderer: App.Renderer = App.makeRenderer(
            autoInitWindow: false,
            update: { [weak self] in
                guard let self else { return }
                x += speed
                if x > Double(width) {
                    x = 0
                }
            },
            draw: { [weak self] in
                guard let self else { return }
                Render.clearBackground(.rayWhite)
                Rect.fill([Int(x), height / 2, 50, 50], color: .orange)
                Text.draw("SwiftUI Host", xy: [20, 20], size: 24, color: .darkGray)
            }
        )

        func start() {
            guard initState == .idle else { return }
            initState = .running
            let configFlags = UInt32(FLAG_WINDOW_HIGHDPI.rawValue)
                | UInt32(FLAG_MSAA_4X_HINT.rawValue)
                | UInt32(FLAG_WINDOW_HIDDEN.rawValue)
            App.initWindow(
                w: width,
                h: height,
                title: "SwiftUI Host",
                targetFPS: 60,
                bgColor: .rayWhite,
                configFlags: configFlags
            )
            App.fps(true)
        }
    }

    @StateObject private var model = ViewModel()

    public init() {}

    public var body: some SwiftUI.View {
        SwiftUI.VStack {
            SwiftUI.Text("I am swiftUI")
            RaylibImageView(renderer: model.renderer)
                .frame(width: CGFloat(model.width), height: CGFloat(model.height))
                .onAppear {
                    model.start()
                }
        }
    }
}
#endif
