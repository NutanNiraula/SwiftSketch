import CRaylib

public extension RayGui {
    protocol DropdownElement: CaseIterable, RawRepresentable where RawValue == String {}
    
    class DropdownBox<T: DropdownElement> {
        private var editMode = false
        public let rect: Rectangle
        public var dropDownActiveIndex: Int = 0
        public var onSelected: (T) -> Void
        private var optionsString: String = ""
        
        public init?(rect: Rectangle, selectedItem: T?, onItemSelected: @escaping (T) -> Void, editMode: Bool = false) {
            self.rect = rect
            self.editMode = editMode
            self.onSelected = onItemSelected
            guard !T.self.allCases.isEmpty else { return nil }
            for element in T.self.allCases {
                self.optionsString += element.rawValue == T.self.allCases.first!.rawValue ?
                                    element.rawValue :
                                    ";\(element.rawValue)"
            }
        }
        
        public func run() {
            var index = Int32(dropDownActiveIndex)
            if GuiDropdownBox(rect, optionsString, &index, editMode) != 0 {
                dropDownActiveIndex = Int(index)
                if editMode == true { // Only emit when dropdown is open and item is selected
                    onSelected(T(rawValue: Array(T.allCases)[dropDownActiveIndex].rawValue)!)
                }
                editMode.toggle()
            }
        }
    }
}
