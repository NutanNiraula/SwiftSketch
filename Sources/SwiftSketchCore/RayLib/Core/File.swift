import CRaylib

public enum File {
    public static func loadFileData(_ fileName: String, bytesRead: UnsafeMutablePointer<UInt32>? = nil) -> UnsafeMutablePointer<UInt8>? {
        fileName.withCString { LoadFileData($0, bytesRead) }
    }
    
    public static func unloadFileData(_ data: UnsafeMutablePointer<UInt8>?) {
        UnloadFileData(data)
    }
    
    public static func saveFileData(_ fileName: String, data: UnsafeRawPointer, size: Int) -> Bool {
        fileName.withCString { ptr -> Bool in
            SaveFileData(ptr, UnsafeMutableRawPointer(mutating: data), Int32(size))
        }
    }
    
    public static func exportDataAsCode(_ data: UnsafePointer<UInt8>, size: Int, fileName: String) -> Bool {
        fileName.withCString { ExportDataAsCode(data, Int32(size), $0) }
    }
    
    public static func loadFileText(_ fileName: String) -> UnsafeMutablePointer<CChar>? {
        fileName.withCString { LoadFileText($0) }
    }
    
    public static func unloadFileText(_ text: UnsafeMutablePointer<CChar>?) {
        UnloadFileText(text)
    }
    
    public static func saveFileText(_ fileName: String, text: UnsafeMutablePointer<CChar>) -> Bool {
        fileName.withCString { SaveFileText($0, text) }
    }
    
    public static func setLoadFileDataCallback(_ callback: LoadFileDataCallback?) {
        SetLoadFileDataCallback(callback)
    }
    
    public static func setSaveFileDataCallback(_ callback: SaveFileDataCallback?) {
        SetSaveFileDataCallback(callback)
    }
    
    public static func setLoadFileTextCallback(_ callback: LoadFileTextCallback?) {
        SetLoadFileTextCallback(callback)
    }
    
    public static func setSaveFileTextCallback(_ callback: SaveFileTextCallback?) {
        SetSaveFileTextCallback(callback)
    }
    
    public static func fileRename(_ fileName: String, newFileName: String) -> Bool {
        fileName.withCString { namePtr -> Bool in
            newFileName.withCString { newNamePtr -> Bool in
                FileRename(namePtr, newNamePtr) != 0
            }
        }
    }
    
    public static func fileRemove(_ fileName: String) -> Bool {
        fileName.withCString { ptr -> Bool in
            FileRemove(ptr) != 0
        }
    }
    
    public static func fileCopy(_ fileName: String, newFileName: String) -> Bool {
        fileName.withCString { namePtr -> Bool in
            newFileName.withCString { newNamePtr -> Bool in
                FileCopy(namePtr, newNamePtr) != 0
            }
        }
    }
    
    public static func fileMove(_ fileName: String, newFileName: String) -> Bool {
        fileName.withCString { namePtr -> Bool in
            newFileName.withCString { newNamePtr -> Bool in
                FileMove(namePtr, newNamePtr) != 0
            }
        }
    }
    
    public static func fileTextReplace(_ text: UnsafeMutablePointer<CChar>, replace: String, with value: String) -> Bool {
        replace.withCString { replacePtr -> Bool in
            value.withCString { valuePtr -> Bool in
                FileTextReplace(text, replacePtr, valuePtr) != 0
            }
        }
    }
    
    public static func fileTextFindIndex(_ text: String, find: String) -> Int {
        text.withCString { textPtr in
            find.withCString { findPtr in
                Int(FileTextFindIndex(textPtr, findPtr))
            }
        }
    }
    
    public static func fileExists(_ fileName: String) -> Bool {
        fileName.withCString { FileExists($0) }
    }
    
    public static func directoryExists(_ dirPath: String) -> Bool {
        dirPath.withCString { DirectoryExists($0) }
    }
    
    public static func isFileExtension(_ fileName: String, ext: String) -> Bool {
        fileName.withCString { namePtr in
            ext.withCString { extPtr in
                IsFileExtension(namePtr, extPtr)
            }
        }
    }
    
    public static func getFileLength(_ fileName: String) -> Int {
        fileName.withCString { Int(GetFileLength($0)) }
    }
    
    public static func getFileModTime(_ fileName: String) -> Int {
        fileName.withCString { Int(GetFileModTime($0)) }
    }
    
    public static func getFileExtension(_ fileName: String) -> String {
        fileName.withCString { ptr in
            guard let result = GetFileExtension(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func getFileName(_ filePath: String) -> String {
        filePath.withCString { ptr in
            guard let result = GetFileName(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func getFileNameWithoutExt(_ filePath: String) -> String {
        filePath.withCString { ptr in
            guard let result = GetFileNameWithoutExt(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func getDirectoryPath(_ filePath: String) -> String {
        filePath.withCString { ptr in
            guard let result = GetDirectoryPath(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func getPrevDirectoryPath(_ dirPath: String) -> String {
        dirPath.withCString { ptr in
            guard let result = GetPrevDirectoryPath(ptr) else { return "" }
            return String(cString: result)
        }
    }
    
    public static func getWorkingDirectory() -> String {
        guard let result = GetWorkingDirectory() else { return "" }
        return String(cString: result)
    }
    
    public static func getApplicationDirectory() -> String {
        guard let result = GetApplicationDirectory() else { return "" }
        return String(cString: result)
    }
    
    public static func makeDirectory(_ dirPath: String) -> Bool {
        dirPath.withCString { ptr -> Bool in
            MakeDirectory(ptr) != 0
        }
    }
    
    public static func changeDirectory(_ dir: String) -> Bool {
        dir.withCString { ChangeDirectory($0) }
    }
    
    public static func isPathFile(_ path: String) -> Bool {
        path.withCString { IsPathFile($0) }
    }
    
    public static func isFileNameValid(_ fileName: String) -> Bool {
        fileName.withCString { IsFileNameValid($0) }
    }
    
    public static func loadDirectoryFiles(_ dirPath: String) -> FilePathList {
        dirPath.withCString { LoadDirectoryFiles($0) }
    }
    
    public static func loadDirectoryFilesEx(_ basePath: String, filter: String, scanSubdirs: Bool) -> FilePathList {
        basePath.withCString { basePtr in
            filter.withCString { filterPtr in
                LoadDirectoryFilesEx(basePtr, filterPtr, scanSubdirs)
            }
        }
    }
    
    public static func unloadDirectoryFiles(_ files: FilePathList) {
        UnloadDirectoryFiles(files)
    }
    
    public static func isFileDropped() -> Bool {
        IsFileDropped()
    }
    
    public static func loadDroppedFiles() -> FilePathList {
        LoadDroppedFiles()
    }
    
    public static func unloadDroppedFiles(_ files: FilePathList) {
        UnloadDroppedFiles(files)
    }
    
    public static func getDirectoryFileCount(_ dirPath: String) -> Int {
        dirPath.withCString { Int(GetDirectoryFileCount($0)) }
    }
    
    public static func getDirectoryFileCountEx(_ basePath: String, filter: String, scanSubdirs: Bool) -> Int {
        basePath.withCString { basePtr in
            filter.withCString { filterPtr in
                Int(GetDirectoryFileCountEx(basePtr, filterPtr, scanSubdirs))
            }
        }
    }
}
