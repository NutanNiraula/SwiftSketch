import CRaylib
import Foundation

public enum Anim {
    @resultBuilder
    public enum KeyframesBuilder {
        public static func buildExpression<T>(_ expression: Keyframe<T>) -> [Keyframe<T>] {
            [expression]
        }
        public static func buildBlock<T>(_ components: [Keyframe<T>]...) -> [Keyframe<T>] {
            components.flatMap { $0 }
        }
        public static func buildOptional<T>(_ component: [Keyframe<T>]?) -> [Keyframe<T>] {
            component ?? []
        }
        public static func buildEither<T>(first component: [Keyframe<T>]) -> [Keyframe<T>] {
            component
        }
        public static func buildEither<T>(second component: [Keyframe<T>]) -> [Keyframe<T>] {
            component
        }
        public static func buildArray<T>(_ components: [[Keyframe<T>]]) -> [Keyframe<T>] {
            components.flatMap { $0 }
        }
    }

    @resultBuilder
    public enum SceneBuilder {
        public static func buildExpression(_ expression: Node2D) -> [Node2D] { [expression] }
        public static func buildBlock(_ components: [Node2D]...) -> [Node2D] {
            components.flatMap { $0 }
        }
        public static func buildOptional(_ component: [Node2D]?) -> [Node2D] { component ?? [] }
        public static func buildEither(first component: [Node2D]) -> [Node2D] { component }
        public static func buildEither(second component: [Node2D]) -> [Node2D] { component }
        public static func buildArray(_ components: [[Node2D]]) -> [Node2D] {
            components.flatMap { $0 }
        }
    }

    public enum Easing {
        case linear
        case easeIn
        case easeOut
        case easeInOut

        func apply(_ t: Double) -> Double {
            switch self {
            case .linear: return t
            case .easeIn: return t * t
            case .easeOut: return 1 - (1 - t) * (1 - t)
            case .easeInOut:
                if t < 0.5 { return 2 * t * t }
                let u = t - 0.5
                return 0.5 + 2 * u - 2 * u * u
            }
        }
    }

    public protocol Interpolatable {
        static func lerp(_ a: Self, _ b: Self, _ t: Double) -> Self
    }

    public struct Keyframe<T> {
        public let time: Double
        public let value: T
        public let easing: Easing
        public init(_ time: Double, _ value: T, _ easing: Easing = .linear) {
            self.time = time
            self.value = value
            self.easing = easing
        }
    }

    public struct Track<T: Interpolatable> {
        public var keyframes: [Keyframe<T>]
        public init(_ keyframes: [Keyframe<T>]) {
            self.keyframes = keyframes.sorted { $0.time < $1.time }
        }
        public init(@KeyframesBuilder _ content: () -> [Keyframe<T>]) {
            self.init(content())
        }
        public func adding(_ kf: Keyframe<T>) -> Track<T> {
            var kfs = keyframes
            kfs.append(kf)
            return Track(kfs)
        }
        public func value(at time: Double) -> T? {
            guard let first = keyframes.first, let last = keyframes.last else { return nil }
            if time <= first.time { return first.value }
            if time >= last.time { return last.value }

            var lo = 0
            var hi = keyframes.count - 1

            // Binary search to find the interval [a, b] where a.time <= time <= b.time
            while lo < hi {
                let mid = (lo + hi) / 2
                if keyframes[mid].time < time {
                    if keyframes[mid + 1].time >= time {
                        lo = mid
                        break
                    }
                    lo = mid + 1
                } else {
                    hi = mid
                }
            }

            let a = keyframes[lo]
            let b = keyframes[lo + 1]

            let span = b.time - a.time
            if span <= 0 { return a.value }
            let t = (time - a.time) / span
            let e = b.easing.apply(t)
            return T.lerp(a.value, b.value, e)
        }
    }

    public struct Transform2D: Interpolatable {
        public var position: Vector2
        public var scale: Vector2
        public var rotation: Double
        public var color: Color
        public init(
            position: Vector2 = .init(0, 0), scale: Vector2 = .square(1), rotation: Double = 0,
            color: Color = .white
        ) {
            self.position = position
            self.scale = scale
            self.rotation = rotation
            self.color = color
        }
        public static func lerp(_ a: Transform2D, _ b: Transform2D, _ t: Double) -> Transform2D {
            Transform2D(
                position: a.position.lerp(to: b.position, t),
                scale: a.scale.lerp(to: b.scale, t),
                rotation: a.rotation.lerp(to: b.rotation, t),
                color: a.color.lerp(to: b.color, t)
            )
        }
    }

    public struct Path2D: Interpolatable {
        public var points: [Vector2]
        public init(_ points: [Vector2]) {
            self.points = points
        }
        public static func circle(center: Vector2, radius: Double, resolution: Int = 128) -> Path2D
        {
            var pts: [Vector2] = []
            pts.reserveCapacity(resolution)
            for i in 0..<resolution {
                let angle = (Double(i) / Double(resolution)) * 2.0 * Double.pi
                pts.append(
                    Vector2(
                        Double(center.x) + cos(angle) * radius,
                        Double(center.y) + sin(angle) * radius
                    ))
            }
            return Path2D(pts)
        }
        public static func polygon(
            center: Vector2, radius: Double, sides: Int, rotation: Double = 0, resolution: Int = 128
        ) -> Path2D {
            var pts: [Vector2] = []
            pts.reserveCapacity(resolution)
            for i in 0..<resolution {
                let t = Double(i) / Double(resolution)
                let sideIndex = Int(floor(t * Double(sides))) % sides
                let sideT = (t * Double(sides)).truncatingRemainder(dividingBy: 1.0)

                let a1 = (Double(sideIndex) / Double(sides)) * 2.0 * Double.pi + rotation
                let a2 = (Double(sideIndex + 1) / Double(sides)) * 2.0 * Double.pi + rotation

                let p1 = Vector2(
                    Double(center.x) + cos(a1) * radius, Double(center.y) + sin(a1) * radius)
                let p2 = Vector2(
                    Double(center.x) + cos(a2) * radius, Double(center.y) + sin(a2) * radius)

                pts.append(p1.lerp(to: p2, sideT))
            }
            return Path2D(pts)
        }
        public static func rectangle(
            center: Vector2, width: Double, height: Double, resolution: Int = 128
        ) -> Path2D {
            let hw = width * 0.5
            let hh = height * 0.5
            let perimeter = 2.0 * (width + height)
            var pts: [Vector2] = []
            pts.reserveCapacity(resolution)

            for i in 0..<resolution {
                let d = (Double(i) / Double(resolution)) * perimeter
                if d < width {
                    pts.append(Vector2(Double(center.x) - hw + d, Double(center.y) - hh))
                } else if d < width + height {
                    pts.append(Vector2(Double(center.x) + hw, Double(center.y) - hh + (d - width)))
                } else if d < 2.0 * width + height {
                    pts.append(
                        Vector2(Double(center.x) + hw - (d - width - height), Double(center.y) + hh)
                    )
                } else {
                    pts.append(
                        Vector2(
                            Double(center.x) - hw,
                            Double(center.y) + hh - (d - 2.0 * width - height)))
                }
            }
            return Path2D(pts)
        }
        public static func star(
            center: Vector2, radius: Double, inner: Double, points: Int, rotation: Double = 0,
            resolution: Int = 128
        ) -> Path2D {
            var pts: [Vector2] = []
            let totalSegments = points * 2
            pts.reserveCapacity(resolution)

            for i in 0..<resolution {
                let t = Double(i) / Double(resolution)
                let segIndex = Int(floor(t * Double(totalSegments))) % totalSegments
                let segT = (t * Double(totalSegments)).truncatingRemainder(dividingBy: 1.0)

                let r1 = (segIndex % 2 == 0) ? radius : inner
                let a1 = (Double(segIndex) / Double(totalSegments)) * 2.0 * Double.pi + rotation
                let p1 = Vector2(Double(center.x) + cos(a1) * r1, Double(center.y) + sin(a1) * r1)

                let r2 = ((segIndex + 1) % 2 == 0) ? radius : inner
                let a2 = (Double(segIndex + 1) / Double(totalSegments)) * 2.0 * Double.pi + rotation
                let p2 = Vector2(Double(center.x) + cos(a2) * r2, Double(center.y) + sin(a2) * r2)

                pts.append(p1.lerp(to: p2, segT))
            }
            return Path2D(pts)
        }
        public static func lerp(_ a: Path2D, _ b: Path2D, _ t: Double) -> Path2D {
            let maxCount = max(a.points.count, b.points.count)
            if maxCount == 0 { return Path2D([]) }

            let pa = a.points.count == maxCount ? a.points : resample(a.points, target: maxCount)
            let pb = b.points.count == maxCount ? b.points : resample(b.points, target: maxCount)

            // Ensure proper correspondence by finding optimal starting point
            let alignedB = alignPoints(source: pa, target: pb)

            var out: [Vector2] = []
            out.reserveCapacity(maxCount)
            for i in 0..<maxCount {
                out.append(pa[i].lerp(to: alignedB[i], t))
            }
            return Path2D(out)
        }

        static func alignPoints(source: [Vector2], target: [Vector2]) -> [Vector2] {
            let count = source.count
            guard count == target.count, count > 0 else { return target }

            // Find the optimal starting point by minimizing the total distance
            // between corresponding points when the target is circularly shifted
            func computeShiftScore(shift: Int) -> Double {
                var totalDistance = 0.0
                for i in 0..<count {
                    let targetIndex = (i + shift) % count
                    totalDistance += source[i].distance(to: target[targetIndex])
                }
                return totalDistance
            }

            // Try all possible shifts to find the best alignment
            var bestShift = 0
            var bestScore = computeShiftScore(shift: 0)

            for shift in 1..<count {
                let score = computeShiftScore(shift: shift)
                if score < bestScore {
                    bestScore = score
                    bestShift = shift
                }
            }

            // Apply the best shift
            return (0..<count).map { target[($0 + bestShift) % count] }
        }

        public static func resample(_ pts: [Vector2], target: Int) -> [Vector2] {
            if pts.isEmpty { return Array(repeating: Vector2(0, 0), count: target) }
            if pts.count == target { return pts }
            if pts.count == 1 { return Array(repeating: pts[0], count: target) }

            // Build cumulative arc length array
            var lengths: [Double] = [0]
            for i in 1..<pts.count {
                lengths.append(lengths.last! + pts[i - 1].distance(to: pts[i]))
            }
            let totalLength = lengths.last!

            if totalLength <= 1e-9 { return Array(repeating: pts[0], count: target) }

            var out: [Vector2] = []
            out.reserveCapacity(target)

            for i in 0..<target {
                let u = Double(i) / Double(max(1, target - 1))
                let targetDist = u * totalLength

                // Find segment containing targetDist
                var segmentIndex = 0
                for j in 1..<lengths.count {
                    if lengths[j] >= targetDist {
                        segmentIndex = j - 1
                        break
                    }
                }

                // Interpolate within segment
                let a = lengths[segmentIndex]
                let b = lengths[segmentIndex + 1]
                let segLen = b - a

                if segLen > 1e-9 {
                    let t = (targetDist - a) / segLen
                    out.append(pts[segmentIndex].lerp(to: pts[segmentIndex + 1], t))
                } else {
                    out.append(pts[segmentIndex])
                }
            }

            return out
        }
    }

    public protocol AnimContent2D {
        func draw(using transform: Transform2D, pathOverride: Path2D?)
    }

    public struct RectShape: AnimContent2D {
        public var rect: Rectangle
        public var origin: Vector2
        public init(rect: Rectangle, origin: Vector2 = .init(0, 0)) {
            self.rect = rect
            self.origin = origin
        }
        public func draw(using transform: Transform2D, pathOverride: Path2D?) {
            let color = transform.color
            let scaled = Rectangle(
                x: rect.x + Float(transform.position.x),
                y: rect.y + Float(transform.position.y),
                width: rect.width * Float(transform.scale.x),
                height: rect.height * Float(transform.scale.y)
            )
            Rect.pro(r: scaled, origin: origin, rot: transform.rotation, color: color)
        }
    }

    public struct CircleShape: AnimContent2D {
        public var center: Vector2
        public var radius: Double
        public init(center: Vector2, radius: Double) {
            self.center = center
            self.radius = radius
        }
        public func draw(using transform: Transform2D, pathOverride: Path2D?) {
            let color = transform.color
            let pos = Vector2(
                Double(center.x + transform.position.x), Double(center.y + transform.position.y))
            let r = radius * Double(max(transform.scale.x, transform.scale.y))
            Circle.vector(xy: pos, r: r, color: color)
        }
    }

    public struct PathShape: AnimContent2D {
        public var path: Path2D
        public var closed: Bool
        public init(path: Path2D, closed: Bool = false) {
            self.path = path
            self.closed = closed
        }
        public func draw(using transform: Transform2D, pathOverride: Path2D?) {
            let pts = (pathOverride ?? path).points
            if pts.isEmpty { return }
            let color = transform.color
            var last = Vector2(
                Double(pts[0].x * transform.scale.x + transform.position.x),
                Double(pts[0].y * transform.scale.y + transform.position.y)
            )
            for i in 1..<pts.count {
                let p = Vector2(
                    Double(pts[i].x * transform.scale.x + transform.position.x),
                    Double(pts[i].y * transform.scale.y + transform.position.y)
                )
                Line.draw(a: last, b: p, color: color)
                last = p
            }
            if closed {
                let first = Vector2(
                    Double(pts[0].x * transform.scale.x + transform.position.x),
                    Double(pts[0].y * transform.scale.y + transform.position.y)
                )
                Line.draw(a: last, b: first, color: color)
            }
        }
    }

    public struct Node2D {
        public var base: Transform2D
        public var move: Track<Vector2>?
        public var scale: Track<Vector2>?
        public var rotate: Track<Double>?
        public var tint: Track<Color>?
        public var morph: Track<Path2D>?
        public var content: AnimContent2D
        public init(
            base: Transform2D = Transform2D(),
            move: Track<Vector2>? = nil,
            scale: Track<Vector2>? = nil,
            rotate: Track<Double>? = nil,
            tint: Track<Color>? = nil,
            morph: Track<Path2D>? = nil,
            content: AnimContent2D
        ) {
            self.base = base
            self.move = move
            self.scale = scale
            self.rotate = rotate
            self.tint = tint
            self.morph = morph
            self.content = content
        }
        public func transformed(at time: Double) -> Transform2D {
            var t = base
            if let move, let v = move.value(at: time) { t.position = v }
            if let scale, let v = scale.value(at: time) { t.scale = v }
            if let rotate, let v = rotate.value(at: time) { t.rotation = v }
            if let tint, let v = tint.value(at: time) { t.color = v }
            return t
        }
        public func pathOverride(at time: Double) -> Path2D? {
            if let morph { return morph.value(at: time) }
            return nil
        }
        public func draw(at time: Double) {
            content.draw(using: transformed(at: time), pathOverride: pathOverride(at: time))
        }
    }

    public final class Timeline2D {
        public var duration: Double
        public private(set) var time: Double = 0
        public var loop: Bool
        public var nodes: [Node2D]
        public init(duration: Double, loop: Bool = true, nodes: [Node2D]) {
            self.duration = duration
            self.loop = loop
            self.nodes = nodes
        }
        public convenience init(
            duration: Double, loop: Bool = true, @SceneBuilder _ content: () -> [Node2D]
        ) {
            self.init(duration: duration, loop: loop, nodes: content())
        }
        public func update(delta: Double) {
            time += delta
            if loop {
                while time > duration { time -= duration }
            } else {
                if time > duration { time = duration }
            }
        }
        public func draw() {
            for n in nodes { n.draw(at: time) }
        }
        public func reset() { time = 0 }
    }

    public static func kf<T>(_ at: Double, _ value: T, _ easing: Easing = .linear) -> Keyframe<T> {
        Keyframe(at, value, easing)
    }

    public static func track<T: Interpolatable>(@KeyframesBuilder _ content: () -> [Keyframe<T>])
        -> Track<T>
    {
        Track(content())
    }

    public static func move(@KeyframesBuilder _ content: () -> [Keyframe<Vector2>]) -> Track<
        Vector2
    > {
        Track(content())
    }

    public static func scale(@KeyframesBuilder _ content: () -> [Keyframe<Vector2>]) -> Track<
        Vector2
    > {
        Track(content())
    }

    public static func rotate(@KeyframesBuilder _ content: () -> [Keyframe<Double>]) -> Track<
        Double
    > {
        Track(content())
    }

    public static func tint(@KeyframesBuilder _ content: () -> [Keyframe<Color>]) -> Track<Color> {
        Track(content())
    }

    public static func morph(@KeyframesBuilder _ content: () -> [Keyframe<Path2D>]) -> Track<Path2D>
    {
        Track(content())
    }

    public static func rect(
        _ rect: Rectangle,
        origin: Vector2 = .init(0, 0),
        base: Transform2D = Transform2D(),
        move: Track<Vector2>? = nil,
        scale: Track<Vector2>? = nil,
        rotate: Track<Double>? = nil,
        tint: Track<Color>? = nil,
        morph: Track<Path2D>? = nil
    ) -> Node2D {
        Node2D(
            base: base,
            move: move,
            scale: scale,
            rotate: rotate,
            tint: tint,
            morph: morph,
            content: RectShape(rect: rect, origin: origin)
        )
    }

    public static func circle(
        center: Vector2,
        radius: Double,
        base: Transform2D = Transform2D(),
        move: Track<Vector2>? = nil,
        scale: Track<Vector2>? = nil,
        rotate: Track<Double>? = nil,
        tint: Track<Color>? = nil,
        morph: Track<Path2D>? = nil
    ) -> Node2D {
        Node2D(
            base: base,
            move: move,
            scale: scale,
            rotate: rotate,
            tint: tint,
            morph: morph,
            content: CircleShape(center: center, radius: radius)
        )
    }

    public static func path(
        _ path: Path2D,
        closed: Bool = false,
        base: Transform2D = Transform2D(),
        move: Track<Vector2>? = nil,
        scale: Track<Vector2>? = nil,
        rotate: Track<Double>? = nil,
        tint: Track<Color>? = nil,
        morph: Track<Path2D>? = nil
    ) -> Node2D {
        Node2D(
            base: base,
            move: move,
            scale: scale,
            rotate: rotate,
            tint: tint,
            morph: morph,
            content: PathShape(path: path, closed: closed)
        )
    }

    public static func timeline(
        duration: Double, loop: Bool = true, @SceneBuilder _ content: () -> [Node2D]
    ) -> Timeline2D {
        Timeline2D(duration: duration, loop: loop, nodes: content())
    }
}

extension Double: Anim.Interpolatable {
    public static func lerp(_ a: Double, _ b: Double, _ t: Double) -> Double {
        a.lerp(to: b, t)
    }
}

extension Vector2: Anim.Interpolatable {
    public static func lerp(_ a: Vector2, _ b: Vector2, _ t: Double) -> Vector2 {
        a.lerp(to: b, t)
    }
}

extension Color: Anim.Interpolatable {
    public static func lerp(_ a: Color, _ b: Color, _ t: Double) -> Color {
        a.lerp(to: b, t)
    }
}

extension Anim.Node2D {
    public func withBase(_ base: Anim.Transform2D) -> Anim.Node2D {
        Anim.Node2D(
            base: base,
            move: move,
            scale: scale,
            rotate: rotate,
            tint: tint,
            morph: morph,
            content: content
        )
    }
    public func moved(_ track: Anim.Track<Vector2>?) -> Anim.Node2D {
        Anim.Node2D(
            base: base,
            move: track,
            scale: scale,
            rotate: rotate,
            tint: tint,
            morph: morph,
            content: content
        )
    }
    public func scaled(_ track: Anim.Track<Vector2>?) -> Anim.Node2D {
        Anim.Node2D(
            base: base,
            move: move,
            scale: track,
            rotate: rotate,
            tint: tint,
            morph: morph,
            content: content
        )
    }
    public func rotated(_ track: Anim.Track<Double>?) -> Anim.Node2D {
        Anim.Node2D(
            base: base,
            move: move,
            scale: scale,
            rotate: track,
            tint: tint,
            morph: morph,
            content: content
        )
    }
    public func tinted(_ track: Anim.Track<Color>?) -> Anim.Node2D {
        Anim.Node2D(
            base: base,
            move: move,
            scale: scale,
            rotate: rotate,
            tint: track,
            morph: morph,
            content: content
        )
    }
    public func morphed(_ track: Anim.Track<Anim.Path2D>?) -> Anim.Node2D {
        Anim.Node2D(
            base: base,
            move: move,
            scale: scale,
            rotate: rotate,
            tint: tint,
            morph: track,
            content: content
        )
    }

    // DSL Chainable helpers
    public func base(
        pos: Vector2? = nil, scale: Vector2? = nil, rot: Double? = nil, color: Color? = nil
    ) -> Anim.Node2D {
        var t = base
        if let p = pos { t.position = p }
        if let s = scale { t.scale = s }
        if let r = rot { t.rotation = r }
        if let c = color { t.color = c }
        return withBase(t)
    }

    public func move(_ time: Double, to val: Vector2, _ ease: Anim.Easing = .linear) -> Anim.Node2D
    {
        let kf = Anim.Keyframe(time, val, ease)
        let t = (move ?? Anim.Track([])).adding(kf)
        return moved(t)
    }

    public func scale(_ time: Double, to val: Vector2, _ ease: Anim.Easing = .linear) -> Anim.Node2D
    {
        let kf = Anim.Keyframe(time, val, ease)
        let t = (scale ?? Anim.Track([])).adding(kf)
        return scaled(t)
    }

    public func rotate(_ time: Double, to val: Double, _ ease: Anim.Easing = .linear) -> Anim.Node2D
    {
        let kf = Anim.Keyframe(time, val, ease)
        let t = (rotate ?? Anim.Track([])).adding(kf)
        return rotated(t)
    }

    public func tint(_ time: Double, to val: Color, _ ease: Anim.Easing = .linear) -> Anim.Node2D {
        let kf = Anim.Keyframe(time, val, ease)
        let t = (tint ?? Anim.Track([])).adding(kf)
        return tinted(t)
    }

    public func morph(_ time: Double, to val: Anim.Path2D, _ ease: Anim.Easing = .linear)
        -> Anim.Node2D
    {
        let kf = Anim.Keyframe(time, val, ease)
        let t = (morph ?? Anim.Track([])).adding(kf)
        return morphed(t)
    }

    public func morphVia(
        _ time: Double,
        to val: Anim.Path2D,
        via: Anim.Path2D,
        viaAmount: Double = 0.9,
        viaTimeRatio: Double = 0.4,
        holdDuration: Double = 0.0,
        _ ease: Anim.Easing = .linear
    ) -> Anim.Node2D {
        guard let last = morph?.keyframes.last else {
            return morph(time, to: val, ease)
        }

        let duration = time - last.time
        if duration <= 0 {
            return morph(time, to: val, ease)
        }

        let clampedAmount = max(0.0, min(1.0, viaAmount))
        let clampedRatio = max(0.0, min(1.0, viaTimeRatio))
        let clampedHold = max(0.0, min(duration, holdDuration))

        let holdTime = last.time + clampedHold
        let midTime = holdTime + (duration - clampedHold) * clampedRatio

        let effectiveDuration = duration - clampedHold
        let midProgress = effectiveDuration > 0 ? clampedRatio : 0.0
        let onTrackValue = Anim.Path2D.lerp(last.value, val, midProgress)

        let midValue = Anim.Path2D.lerp(onTrackValue, via, clampedAmount)

        var t = morph ?? Anim.Track([])

        if clampedHold > 0 {
            t = t.adding(Anim.Keyframe(holdTime, last.value, .linear))
        }

        t = t.adding(Anim.Keyframe(midTime, midValue, ease))
        t = t.adding(Anim.Keyframe(time, val, ease))

        return morphed(t)
    }
}
