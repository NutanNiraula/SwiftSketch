import CRaylib

public enum RayGui {
    public static func button(_ rect: Rectangle, _ title: String) -> Bool {
        GuiButton(rect, title) != 0
    }
}
