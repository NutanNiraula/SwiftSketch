import Foundation
import CRaylib
import CImGui

public enum ImGuiTheme {
    case dark
    case light
    case classic
}

public struct ImGuiWindowOptions: OptionSet {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let none: ImGuiWindowOptions = []
    public static let noTitleBar = ImGuiWindowOptions(rawValue: 1 << 0)
    public static let noResize = ImGuiWindowOptions(rawValue: 1 << 1)
    public static let noMove = ImGuiWindowOptions(rawValue: 1 << 2)
    public static let noCollapse = ImGuiWindowOptions(rawValue: 1 << 5)
    public static let alwaysAutoResize = ImGuiWindowOptions(rawValue: 1 << 6)
}

public enum ImGuiUI {
    public static func begin(_ title: String, options: ImGuiWindowOptions = .none) -> Bool {
        igBegin(title, nil, Int32(options.rawValue))
    }
    
    public static func end() {
        igEnd()
    }
    
    public static func text(_ text: String) {
        igTextUnformatted(text, nil)
    }
    
    public static func separator() {
        igSeparator()
    }
    
    public static func button(_ label: String, size: ImVec2 = ImVec2(x: 0, y: 0)) -> Bool {
        igButton(label, size)
    }
    
    public static func checkbox(_ label: String, value: inout Bool) -> Bool {
        var current = value
        let changed = igCheckbox(label, &current)
        value = current
        return changed
    }
    
    public static func sliderFloat(
        _ label: String,
        value: inout Double,
        min: Double,
        max: Double,
        format: String = "%.3f",
        flags: ImGuiSliderFlags = 0
    ) -> Bool {
        var current = Float(value)
        let changed = igSliderFloat(label, &current, Float(min), Float(max), format, flags)
        value = Double(current)
        return changed
    }
    
    public static func sliderInt(
        _ label: String,
        value: inout Int,
        min: Int,
        max: Int,
        format: String = "%d",
        flags: ImGuiSliderFlags = 0
    ) -> Bool {
        var current = Int32(value)
        let changed = igSliderInt(label, &current, Int32(min), Int32(max), format, flags)
        value = Int(current)
        return changed
    }
    
    public static func inputText(
        _ label: String,
        buffer: inout [CChar],
        flags: ImGuiInputTextFlags = 0
    ) -> Bool {
        let size = buffer.count
        guard size > 0 else { return false }
        return buffer.withUnsafeMutableBufferPointer { ptr in
            guard let base = ptr.baseAddress else { return false }
            return igInputText(label, base, size, flags, nil, nil)
        }
    }
    
    public static func inputInt(
        _ label: String,
        value: inout Int,
        step: Int = 1,
        stepFast: Int = 100,
        flags: ImGuiInputTextFlags = 0
    ) -> Bool {
        var current = Int32(value)
        let changed = igInputInt(label, &current, Int32(step), Int32(stepFast), flags)
        value = Int(current)
        return changed
    }
    
    public static func combo(
        _ label: String,
        currentIndex: inout Int,
        items: [String],
        maxVisible: Int = -1
    ) -> Bool {
        var current = Int32(currentIndex)
        let cStrings = items.map { strdup($0) }
        defer { cStrings.forEach { free($0) } }
        let pointers = cStrings.map { UnsafePointer($0) }
        let changed = pointers.withUnsafeBufferPointer { ptr in
            guard let base = ptr.baseAddress else { return false }
            return igCombo_Str_arr(label, &current, base, Int32(items.count), Int32(maxVisible))
        }
        currentIndex = Int(current)
        return changed
    }
    
    public static func progressBar(
        _ fraction: Double,
        size: ImVec2 = ImVec2(x: 0, y: 0),
        overlay: String? = nil
    ) {
        if let overlay {
            overlay.withCString { text in
                igProgressBar(Float(fraction), size, text)
            }
        } else {
            igProgressBar(Float(fraction), size, nil)
        }
    }
    
    public static func colorEdit3(
        _ label: String,
        values: inout [Double],
        flags: ImGuiColorEditFlags = 0
    ) -> Bool {
        guard values.count >= 3 else { return false }
        var colors = values.prefix(3).map { Float($0) }
        let changed = colors.withUnsafeMutableBufferPointer { ptr in
            guard let base = ptr.baseAddress else { return false }
            return igColorEdit3(label, base, flags)
        }
        for index in 0..<3 {
            values[index] = Double(colors[index])
        }
        return changed
    }
    
    public static func colorEdit4(
        _ label: String,
        values: inout [Double],
        flags: ImGuiColorEditFlags = 0
    ) -> Bool {
        guard values.count >= 4 else { return false }
        var colors = values.prefix(4).map { Float($0) }
        let changed = colors.withUnsafeMutableBufferPointer { ptr in
            guard let base = ptr.baseAddress else { return false }
            return igColorEdit4(label, base, flags)
        }
        for index in 0..<4 {
            values[index] = Double(colors[index])
        }
        return changed
    }
}

public protocol View {
    func render()
}

@resultBuilder
public enum ViewBuilder {
    public static func buildExpression(_ expression: View) -> [View] { [expression] }
    public static func buildBlock(_ components: [View]...) -> [View] { components.flatMap { $0 } }
    public static func buildOptional(_ component: [View]?) -> [View] { component ?? [] }
    public static func buildEither(first component: [View]) -> [View] { component }
    public static func buildEither(second component: [View]) -> [View] { component }
    public static func buildArray(_ components: [[View]]) -> [View] { components.flatMap { $0 } }
}

public struct Window: View {
    public let title: String
    public let options: ImGuiWindowOptions
    public let content: [View]
    
    public init(
        _ title: String,
        options: ImGuiWindowOptions = .none,
        @ViewBuilder content: () -> [View]
    ) {
        self.title = title
        self.options = options
        self.content = content()
    }
    
    public func render() {
        let opened = igBegin(title, nil, Int32(options.rawValue))
        if opened {
            content.forEach { $0.render() }
        }
        igEnd()
    }
}

public struct VStack: View {
    public let spacing: Double?
    public let content: [View]
    
    public init(spacing: Double? = nil, @ViewBuilder content: () -> [View]) {
        self.spacing = spacing
        self.content = content()
    }
    
    public func render() {
        for index in content.indices {
            if index > 0 {
                if let spacing {
                    igDummy(ImVec2(x: 0, y: Float(spacing)))
                } else {
                    igSpacing()
                }
            }
            content[index].render()
        }
    }
}

public struct HStack: View {
    public let spacing: Double?
    public let content: [View]
    
    public init(spacing: Double? = nil, @ViewBuilder content: () -> [View]) {
        self.spacing = spacing
        self.content = content()
    }
    
    public func render() {
        for index in content.indices {
            if index > 0 {
                let spacingValue = Float(spacing ?? -1)
                igSameLine(0, spacingValue)
            }
            content[index].render()
        }
    }
}

public struct ZStack: View {
    public let content: [View]
    
    public init(@ViewBuilder content: () -> [View]) {
        self.content = content()
    }
    
    public func render() {
        let start = igGetCursorScreenPos()
        for view in content {
            igSetCursorScreenPos(start)
            view.render()
        }
    }
}

public struct ImText: View {
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public func render() {
        igTextUnformatted(value, nil)
    }
}

public struct Button: View {
    public let label: String
    public let size: ImVec2
    public let action: (() -> Void)?
    
    public init(_ label: String, size: ImVec2 = ImVec2(x: 0, y: 0), action: (() -> Void)? = nil) {
        self.label = label
        self.size = size
        self.action = action
    }
    
    public init(_ label: String, size: ImVec2 = ImVec2(x: 0, y: 0), action: @escaping () -> Void) {
        self.label = label
        self.size = size
        self.action = action
    }
    
    public func render() {
        if igButton(label, size) {
            action?()
        }
    }
}

public struct CheckBox: View {
    public let label: String
    public let isOn: () -> Bool
    public let set: (Bool) -> Void
    
    public init(
        _ label: String,
        isOn: @escaping () -> Bool,
        set: @escaping (Bool) -> Void
    ) {
        self.label = label
        self.isOn = isOn
        self.set = set
    }
    
    public func render() {
        var current = isOn()
        _ = igCheckbox(label, &current)
        set(current)
    }
}

public struct SliderFloat: View {
    public let label: String
    public let min: Double
    public let max: Double
    public let format: String
    public let flags: ImGuiSliderFlags
    public let value: () -> Double
    public let set: (Double) -> Void
    
    public init(
        _ label: String,
        value: @escaping () -> Double,
        set: @escaping (Double) -> Void,
        min: Double,
        max: Double,
        format: String = "%.3f",
        flags: ImGuiSliderFlags = 0
    ) {
        self.label = label
        self.value = value
        self.set = set
        self.min = min
        self.max = max
        self.format = format
        self.flags = flags
    }
    
    public func render() {
        var current = Float(value())
        _ = igSliderFloat(label, &current, Float(min), Float(max), format, flags)
        set(Double(current))
    }
}

public struct SliderInt: View {
    public let label: String
    public let min: Int
    public let max: Int
    public let format: String
    public let flags: ImGuiSliderFlags
    public let value: () -> Int
    public let set: (Int) -> Void
    
    public init(
        _ label: String,
        value: @escaping () -> Int,
        set: @escaping (Int) -> Void,
        min: Int,
        max: Int,
        format: String = "%d",
        flags: ImGuiSliderFlags = 0
    ) {
        self.label = label
        self.value = value
        self.set = set
        self.min = min
        self.max = max
        self.format = format
        self.flags = flags
    }
    
    public func render() {
        var current = Int32(value())
        _ = igSliderInt(label, &current, Int32(min), Int32(max), format, flags)
        set(Int(current))
    }
}

public struct InputInt: View {
    public let label: String
    public let step: Int
    public let stepFast: Int
    public let flags: ImGuiInputTextFlags
    public let value: () -> Int
    public let set: (Int) -> Void
    
    public init(
        _ label: String,
        value: @escaping () -> Int,
        set: @escaping (Int) -> Void,
        step: Int = 1,
        stepFast: Int = 100,
        flags: ImGuiInputTextFlags = 0
    ) {
        self.label = label
        self.value = value
        self.set = set
        self.step = step
        self.stepFast = stepFast
        self.flags = flags
    }
    
    public func render() {
        var current = Int32(value())
        _ = igInputInt(label, &current, Int32(step), Int32(stepFast), flags)
        set(Int(current))
    }
}

public struct InputText: View {
    public let label: String
    public let flags: ImGuiInputTextFlags
    public let buffer: () -> [CChar]
    public let set: ([CChar]) -> Void
    
    public init(
        _ label: String,
        buffer: @escaping () -> [CChar],
        set: @escaping ([CChar]) -> Void,
        flags: ImGuiInputTextFlags = 0
    ) {
        self.label = label
        self.buffer = buffer
        self.set = set
        self.flags = flags
    }
    
    public func render() {
        var current = buffer()
        _ = ImGuiUI.inputText(label, buffer: &current, flags: flags)
        set(current)
    }
}

public struct Combo: View {
    public let label: String
    public let items: [String]
    public let maxVisible: Int
    public let selection: () -> Int
    public let set: (Int) -> Void
    
    public init(
        _ label: String,
        items: [String],
        selection: @escaping () -> Int,
        set: @escaping (Int) -> Void,
        maxVisible: Int = -1
    ) {
        self.label = label
        self.items = items
        self.selection = selection
        self.set = set
        self.maxVisible = maxVisible
    }
    
    public func render() {
        var current = selection()
        _ = ImGuiUI.combo(label, currentIndex: &current, items: items, maxVisible: maxVisible)
        set(current)
    }
}

public struct ProgressBar: View {
    public let value: () -> Double
    public let size: ImVec2
    public let overlay: () -> String?
    
    public init(
        _ value: @escaping () -> Double,
        size: ImVec2 = ImVec2(x: 0, y: 0),
        overlay: @escaping () -> String? = { nil }
    ) {
        self.value = value
        self.size = size
        self.overlay = overlay
    }
    
    public func render() {
        ImGuiUI.progressBar(value(), size: size, overlay: overlay())
    }
}

public struct ColorEdit3: View {
    public let label: String
    public let flags: ImGuiColorEditFlags
    public let values: () -> [Double]
    public let set: ([Double]) -> Void
    
    public init(
        _ label: String,
        values: @escaping () -> [Double],
        set: @escaping ([Double]) -> Void,
        flags: ImGuiColorEditFlags = 0
    ) {
        self.label = label
        self.values = values
        self.set = set
        self.flags = flags
    }
    
    public func render() {
        var current = values()
        _ = ImGuiUI.colorEdit3(label, values: &current, flags: flags)
        set(current)
    }
}

public struct ColorEdit4: View {
    public let label: String
    public let flags: ImGuiColorEditFlags
    public let values: () -> [Double]
    public let set: ([Double]) -> Void
    
    public init(
        _ label: String,
        values: @escaping () -> [Double],
        set: @escaping ([Double]) -> Void,
        flags: ImGuiColorEditFlags = 0
    ) {
        self.label = label
        self.values = values
        self.set = set
        self.flags = flags
    }
    
    public func render() {
        var current = values()
        _ = ImGuiUI.colorEdit4(label, values: &current, flags: flags)
        set(current)
    }
}

public struct Divider: View {
    public init() {}
    
    public func render() {
        igSeparator()
    }
}

public struct Block: View {
    public let block: () -> Void
    
    public init(_ block: @escaping () -> Void) {
        self.block = block
    }
    
    public func render() {
        block()
    }
}

public struct ImPlotOptions: OptionSet {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let none: ImPlotOptions = []
    public static let noTitle = ImPlotOptions(rawValue: 1 << 0)
    public static let noLegend = ImPlotOptions(rawValue: 1 << 1)
    public static let noMouseText = ImPlotOptions(rawValue: 1 << 2)
    public static let noInputs = ImPlotOptions(rawValue: 1 << 3)
    public static let noMenus = ImPlotOptions(rawValue: 1 << 4)
    public static let noBoxSelect = ImPlotOptions(rawValue: 1 << 5)
    public static let noFrame = ImPlotOptions(rawValue: 1 << 6)
    public static let equal = ImPlotOptions(rawValue: 1 << 7)
    public static let crosshairs = ImPlotOptions(rawValue: 1 << 8)
    public static let canvasOnly: ImPlotOptions = [.noTitle, .noLegend, .noMenus, .noBoxSelect, .noMouseText]
}

public struct ImPlotAxisOptions: OptionSet {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let none: ImPlotAxisOptions = []
    public static let noLabel = ImPlotAxisOptions(rawValue: 1 << 0)
    public static let noGridLines = ImPlotAxisOptions(rawValue: 1 << 1)
    public static let noTickMarks = ImPlotAxisOptions(rawValue: 1 << 2)
    public static let noTickLabels = ImPlotAxisOptions(rawValue: 1 << 3)
    public static let noInitialFit = ImPlotAxisOptions(rawValue: 1 << 4)
    public static let noMenus = ImPlotAxisOptions(rawValue: 1 << 5)
    public static let noSideSwitch = ImPlotAxisOptions(rawValue: 1 << 6)
    public static let noHighlight = ImPlotAxisOptions(rawValue: 1 << 7)
    public static let opposite = ImPlotAxisOptions(rawValue: 1 << 8)
    public static let foreground = ImPlotAxisOptions(rawValue: 1 << 9)
    public static let invert = ImPlotAxisOptions(rawValue: 1 << 10)
    public static let autoFit = ImPlotAxisOptions(rawValue: 1 << 11)
    public static let rangeFit = ImPlotAxisOptions(rawValue: 1 << 12)
    public static let panStretch = ImPlotAxisOptions(rawValue: 1 << 13)
    public static let lockMin = ImPlotAxisOptions(rawValue: 1 << 14)
    public static let lockMax = ImPlotAxisOptions(rawValue: 1 << 15)
    public static let lock: ImPlotAxisOptions = [.lockMin, .lockMax]
    public static let noDecorations: ImPlotAxisOptions = [.noLabel, .noGridLines, .noTickMarks, .noTickLabels]
    public static let auxDefault: ImPlotAxisOptions = [.noGridLines, .opposite]
}

public struct ImPlotLineOptions: OptionSet {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let none: ImPlotLineOptions = []
    public static let segments = ImPlotLineOptions(rawValue: 1 << 10)
    public static let loop = ImPlotLineOptions(rawValue: 1 << 11)
    public static let skipNaN = ImPlotLineOptions(rawValue: 1 << 12)
    public static let noClip = ImPlotLineOptions(rawValue: 1 << 13)
    public static let shaded = ImPlotLineOptions(rawValue: 1 << 14)
}

public struct ImPlot3DOptions: OptionSet {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let none: ImPlot3DOptions = []
    public static let noTitle = ImPlot3DOptions(rawValue: 1 << 0)
    public static let noLegend = ImPlot3DOptions(rawValue: 1 << 1)
    public static let noMouseText = ImPlot3DOptions(rawValue: 1 << 2)
    public static let noClip = ImPlot3DOptions(rawValue: 1 << 3)
    public static let noMenus = ImPlot3DOptions(rawValue: 1 << 4)
    public static let equal = ImPlot3DOptions(rawValue: 1 << 5)
    public static let noRotate = ImPlot3DOptions(rawValue: 1 << 6)
    public static let noPan = ImPlot3DOptions(rawValue: 1 << 7)
    public static let noZoom = ImPlot3DOptions(rawValue: 1 << 8)
    public static let noInputs = ImPlot3DOptions(rawValue: 1 << 9)
    public static let canvasOnly: ImPlot3DOptions = [.noTitle, .noLegend, .noMouseText]
}

public struct ImPlot3DAxisOptions: OptionSet {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let none: ImPlot3DAxisOptions = []
    public static let noLabel = ImPlot3DAxisOptions(rawValue: 1 << 0)
    public static let noGridLines = ImPlot3DAxisOptions(rawValue: 1 << 1)
    public static let noTickMarks = ImPlot3DAxisOptions(rawValue: 1 << 2)
    public static let noTickLabels = ImPlot3DAxisOptions(rawValue: 1 << 3)
    public static let lockMin = ImPlot3DAxisOptions(rawValue: 1 << 4)
    public static let lockMax = ImPlot3DAxisOptions(rawValue: 1 << 5)
    public static let autoFit = ImPlot3DAxisOptions(rawValue: 1 << 6)
    public static let invert = ImPlot3DAxisOptions(rawValue: 1 << 7)
    public static let panStretch = ImPlot3DAxisOptions(rawValue: 1 << 8)
    public static let lock: ImPlot3DAxisOptions = [.lockMin, .lockMax]
    public static let noDecorations: ImPlot3DAxisOptions = [.noLabel, .noGridLines, .noTickMarks, .noTickLabels]
}

public struct ImPlot3DLineOptions: OptionSet {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let none: ImPlot3DLineOptions = []
    public static let segments = ImPlot3DLineOptions(rawValue: 1 << 10)
    public static let loop = ImPlot3DLineOptions(rawValue: 1 << 11)
    public static let skipNaN = ImPlot3DLineOptions(rawValue: 1 << 12)
}

public struct ImPlotAxis2D {
    public let x: String
    public let y: String
    public let xOptions: ImPlotAxisOptions
    public let yOptions: ImPlotAxisOptions
    
    public init(
        x: String = "",
        y: String = "",
        xOptions: ImPlotAxisOptions = .none,
        yOptions: ImPlotAxisOptions = .none
    ) {
        self.x = x
        self.y = y
        self.xOptions = xOptions
        self.yOptions = yOptions
    }
}

public struct ImPlotAxis3D {
    public let x: String
    public let y: String
    public let z: String
    public let xOptions: ImPlot3DAxisOptions
    public let yOptions: ImPlot3DAxisOptions
    public let zOptions: ImPlot3DAxisOptions
    
    public init(
        x: String = "",
        y: String = "",
        z: String = "",
        xOptions: ImPlot3DAxisOptions = .none,
        yOptions: ImPlot3DAxisOptions = .none,
        zOptions: ImPlot3DAxisOptions = .none
    ) {
        self.x = x
        self.y = y
        self.z = z
        self.xOptions = xOptions
        self.yOptions = yOptions
        self.zOptions = zOptions
    }
}

public protocol ImPlot2DContent {
    func render()
}

@resultBuilder
public enum ImPlot2DBuilder {
    public static func buildExpression(_ expression: ImPlot2DContent) -> [ImPlot2DContent] { [expression] }
    public static func buildBlock(_ components: [ImPlot2DContent]...) -> [ImPlot2DContent] { components.flatMap { $0 } }
    public static func buildOptional(_ component: [ImPlot2DContent]?) -> [ImPlot2DContent] { component ?? [] }
    public static func buildEither(first component: [ImPlot2DContent]) -> [ImPlot2DContent] { component }
    public static func buildEither(second component: [ImPlot2DContent]) -> [ImPlot2DContent] { component }
    public static func buildArray(_ components: [[ImPlot2DContent]]) -> [ImPlot2DContent] { components.flatMap { $0 } }
}

public protocol ImPlot3DContent {
    func render()
}

@resultBuilder
public enum ImPlot3DBuilder {
    public static func buildExpression(_ expression: ImPlot3DContent) -> [ImPlot3DContent] { [expression] }
    public static func buildBlock(_ components: [ImPlot3DContent]...) -> [ImPlot3DContent] { components.flatMap { $0 } }
    public static func buildOptional(_ component: [ImPlot3DContent]?) -> [ImPlot3DContent] { component ?? [] }
    public static func buildEither(first component: [ImPlot3DContent]) -> [ImPlot3DContent] { component }
    public static func buildEither(second component: [ImPlot3DContent]) -> [ImPlot3DContent] { component }
    public static func buildArray(_ components: [[ImPlot3DContent]]) -> [ImPlot3DContent] { components.flatMap { $0 } }
}

public struct ImPlot2D: View {
    public let title: String
    public let width: Double
    public let height: Double
    public let axis: ImPlotAxis2D
    public let options: ImPlotOptions
    public let content: [ImPlot2DContent]
    
    public init(
        _ title: String,
        w: Double,
        h: Double,
        axis: ImPlotAxis2D = .init(),
        options: ImPlotOptions = .none,
        @ImPlot2DBuilder content: () -> [ImPlot2DContent]
    ) {
        self.title = title
        self.width = w
        self.height = h
        self.axis = axis
        self.options = options
        self.content = content()
    }
    
    public func render() {
        if ImPlotUI.begin(title, width: width, height: height, options: options) {
            ImPlotUI.setupAxes(axis.x, axis.y, xOptions: axis.xOptions, yOptions: axis.yOptions)
            content.forEach { $0.render() }
            ImPlotUI.end()
        }
    }
}

public struct ImPlot3D: View {
    public let title: String
    public let width: Double
    public let height: Double
    public let axis: ImPlotAxis3D
    public let options: ImPlot3DOptions
    public let content: [ImPlot3DContent]
    
    public init(
        _ title: String,
        w: Double,
        h: Double,
        axis: ImPlotAxis3D = .init(),
        options: ImPlot3DOptions = .none,
        @ImPlot3DBuilder content: () -> [ImPlot3DContent]
    ) {
        self.title = title
        self.width = w
        self.height = h
        self.axis = axis
        self.options = options
        self.content = content()
    }
    
    public func render() {
        if ImPlot3DUI.begin(title, width: width, height: height, options: options) {
            ImPlot3DUI.setupAxes(axis.x, axis.y, axis.z, xOptions: axis.xOptions, yOptions: axis.yOptions, zOptions: axis.zOptions)
            content.forEach { $0.render() }
            ImPlot3DUI.end()
        }
    }
}

public struct ImPlotLine2D: ImPlot2DContent {
    public let label: String
    public let values: [Double]
    public let xScale: Double
    public let yScale: Double
    public let xStart: Double
    public let options: ImPlotLineOptions
    
    public init(
        _ label: String,
        values: [Double],
        xScale: Double = 1.0,
        yScale: Double = 1.0,
        xStart: Double = 0.0,
        options: ImPlotLineOptions = .none
    ) {
        self.label = label
        self.values = values
        self.xScale = xScale
        self.yScale = yScale
        self.xStart = xStart
        self.options = options
    }
    
    public func render() {
        if yScale == 1.0 {
            ImPlotUI.plotLine(label, values: values, xScale: xScale, xStart: xStart, options: options)
            return
        }
        let scaled = values.map { $0 * yScale }
        ImPlotUI.plotLine(label, values: scaled, xScale: xScale, xStart: xStart, options: options)
    }
}

public struct ImPlotLine3D: ImPlot3DContent {
    public let label: String
    public let xs: [Double]
    public let ys: [Double]
    public let zs: [Double]
    public let options: ImPlot3DLineOptions
    
    public init(
        _ label: String,
        xs: [Double],
        ys: [Double],
        zs: [Double],
        options: ImPlot3DLineOptions = .none
    ) {
        self.label = label
        self.xs = xs
        self.ys = ys
        self.zs = zs
        self.options = options
    }
    
    public func render() {
        ImPlot3DUI.plotLine(label, xs: xs, ys: ys, zs: zs, options: options)
    }
}

public func plotLine(
    _ label: String,
    values: [Double],
    xScale: Double = 1.0,
    yScale: Double = 1.0,
    xStart: Double = 0.0,
    options: ImPlotLineOptions = .none
) -> ImPlot2DContent {
    ImPlotLine2D(label, values: values, xScale: xScale, yScale: yScale, xStart: xStart, options: options)
}

public func plotLine(
    _ label: String,
    xs: [Double],
    ys: [Double],
    zs: [Double],
    options: ImPlot3DLineOptions = .none
) -> ImPlot3DContent {
    ImPlotLine3D(label, xs: xs, ys: ys, zs: zs, options: options)
}

public enum ImPlotUI {
    public static func begin(
        _ title: String,
        size: ImVec2_c = ImVec2_c(x: 0, y: 0),
        options: ImPlotOptions = .none
    ) -> Bool {
        ImPlot_BeginPlot(title, size, options.rawValue)
    }

    public static func begin(
        _ title: String,
        width: Double,
        height: Double,
        options: ImPlotOptions = .none
    ) -> Bool {
        let size = ImVec2_c(x: Float(width), y: Float(height))
        return ImPlot_BeginPlot(title, size, options.rawValue)
    }
    
    public static func end() {
        ImPlot_EndPlot()
    }
    
    public static func setupAxes(
        _ xLabel: String = "",
        _ yLabel: String = "",
        xOptions: ImPlotAxisOptions = .none,
        yOptions: ImPlotAxisOptions = .none
    ) {
        ImPlot_SetupAxes(xLabel, yLabel, xOptions.rawValue, yOptions.rawValue)
    }
    
    public static func plotLine(
        _ label: String,
        values: [Double],
        xScale: Double = 1.0,
        xStart: Double = 0.0,
        options: ImPlotLineOptions = .none
    ) {
        values.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            ImPlot_PlotLine_doublePtrInt(label, base, Int32(buffer.count), xScale, xStart, options.rawValue, 0, Int32(MemoryLayout<Double>.stride))
        }
    }

    public static func plotScatter(
        _ label: String,
        values: [Double],
        xScale: Double = 1.0,
        xStart: Double = 0.0,
        options: ImPlotLineOptions = .none
    ) {
        values.withUnsafeBufferPointer { buffer in
            guard let base = buffer.baseAddress else { return }
            ImPlot_PlotScatter_doublePtrInt(label, base, Int32(buffer.count), xScale, xStart, options.rawValue, 0, Int32(MemoryLayout<Double>.stride))
        }
    }
}

public enum ImPlot3DUI {
    public static func begin(
        _ title: String,
        size: ImVec2_c = ImVec2_c(x: 0, y: 0),
        options: ImPlot3DOptions = .none
    ) -> Bool {
        ImPlot3D_BeginPlot(title, size, options.rawValue)
    }

    public static func begin(
        _ title: String,
        width: Double,
        height: Double,
        options: ImPlot3DOptions = .none
    ) -> Bool {
        let size = ImVec2_c(x: Float(width), y: Float(height))
        return ImPlot3D_BeginPlot(title, size, options.rawValue)
    }
    
    public static func end() {
        ImPlot3D_EndPlot()
    }
    
    public static func setupAxes(
        _ xLabel: String = "",
        _ yLabel: String = "",
        _ zLabel: String = "",
        xOptions: ImPlot3DAxisOptions = .none,
        yOptions: ImPlot3DAxisOptions = .none,
        zOptions: ImPlot3DAxisOptions = .none
    ) {
        ImPlot3D_SetupAxes(xLabel, yLabel, zLabel, xOptions.rawValue, yOptions.rawValue, zOptions.rawValue)
    }
    
    public static func plotLine(
        _ label: String,
        xs: [Double],
        ys: [Double],
        zs: [Double],
        options: ImPlot3DLineOptions = .none
    ) {
        xs.withUnsafeBufferPointer { xBuffer in
            ys.withUnsafeBufferPointer { yBuffer in
                zs.withUnsafeBufferPointer { zBuffer in
                    guard let xBase = xBuffer.baseAddress,
                          let yBase = yBuffer.baseAddress,
                          let zBase = zBuffer.baseAddress else { return }
                    let count = min(xBuffer.count, yBuffer.count, zBuffer.count)
                    if count == 0 { return }
                    ImPlot3D_PlotLine_doublePtr(label, xBase, yBase, zBase, Int32(count), options.rawValue, 0, Int32(MemoryLayout<Double>.stride))
                }
            }
        }
    }

    public static func plotScatter(
        _ label: String,
        xs: [Double],
        ys: [Double],
        zs: [Double],
        options: ImPlot3DLineOptions = .none
    ) {
        xs.withUnsafeBufferPointer { xBuffer in
            ys.withUnsafeBufferPointer { yBuffer in
                zs.withUnsafeBufferPointer { zBuffer in
                    guard let xBase = xBuffer.baseAddress,
                          let yBase = yBuffer.baseAddress,
                          let zBase = zBuffer.baseAddress else { return }
                    let count = min(xBuffer.count, yBuffer.count, zBuffer.count)
                    if count == 0 { return }
                    ImPlot3D_PlotScatter_doublePtr(label, xBase, yBase, zBase, Int32(count), options.rawValue, 0, Int32(MemoryLayout<Double>.stride))
                }
            }
        }
    }
}

enum ImGuiCore {
    static var isInitialized = false
    static var hasImPlotContext = false
    static var hasImPlot3DContext = false
    
    static func initialize(theme: ImGuiTheme, glslVersion: String) {
        guard !isInitialized else { return }
        _ = igCreateContext(nil)
        ImPlot_SetImGuiContext(igGetCurrentContext())
        _ = ImPlot_CreateContext()
        hasImPlotContext = true
        _ = ImPlot3D_CreateContext()
        hasImPlot3DContext = true
        switch theme {
        case .dark:
            igStyleColorsDark(nil)
        case .light:
            igStyleColorsLight(nil)
        case .classic:
            igStyleColorsClassic(nil)
        }
        
        // Scale ImGui for High DPI
        if let io = igGetIO_Nil() {
            let scale = GetWindowScaleDPI()
            io.pointee.DisplayFramebufferScale = ImVec2(x: scale.x, y: scale.y)
        }
        
        ImGui_ImplOpenGL3_Init(glslVersion)
        isInitialized = true
    }
    
    static func newFrame() {
        guard isInitialized else { return }
        ImGui_ImplOpenGL3_NewFrame()
        if let io = igGetIO_Nil() {
            io.pointee.DisplaySize = ImVec2(x: Float(GetScreenWidth()), y: Float(GetScreenHeight()))
            
            let scale = GetWindowScaleDPI()
            io.pointee.DisplayFramebufferScale = ImVec2(x: scale.x, y: scale.y)
            
            let dt = Double(GetFrameTime())
            io.pointee.DeltaTime = dt > 0 ? Float(dt) : 1.0 / 60.0
            
            let mousePos = GetMousePosition()
            io.pointee.MousePos = ImVec2(x: mousePos.x, y: mousePos.y)
            io.pointee.MouseDown.0 = IsMouseButtonDown(0)
            io.pointee.MouseDown.1 = IsMouseButtonDown(1)
            io.pointee.MouseDown.2 = IsMouseButtonDown(2)
            io.pointee.MouseWheel = GetMouseWheelMove()
        }
        igNewFrame()
    }
    
    static func render() {
        guard isInitialized else { return }
        igRender()
        if let drawData = igGetDrawData() {
            ImGui_ImplOpenGL3_RenderDrawData(drawData)
        }
    }
    
    static func shutdown() {
        guard isInitialized else { return }
        if hasImPlotContext {
            ImPlot_DestroyContext(nil)
            hasImPlotContext = false
        }
        if hasImPlot3DContext {
            ImPlot3D_DestroyContext(nil)
            hasImPlot3DContext = false
        }
        ImGui_ImplOpenGL3_Shutdown()
        igDestroyContext(nil)
        isInitialized = false
    }
}
