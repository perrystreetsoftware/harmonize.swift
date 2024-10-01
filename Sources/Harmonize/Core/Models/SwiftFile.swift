import Foundation

/// Swift source file containing types such as classes, functions, variables etc.
public class SwiftFile {
    public let fileHandle: FileHandle
    
    public let fileName: String

    public let filePath: URL
    
    /// Top-level declarations found in this file, excluding nested declarations.
    public var rootDeclarations: [Declaration] = []
    
    /// Declarations found in this file, including nested declarations.
    public var declarations: [Declaration] = []
    
    lazy var sourceText: String? = {
        let sourceData = fileHandle.readDataToEndOfFile()
        defer { fileHandle.closeFile() }
        return String(data: sourceData, encoding: .utf8)
    }()
    
    init(url: URL) throws {
        self.filePath = url
        self.fileName = url.lastPathComponent
        self.fileHandle = try FileHandle(forReadingFrom: url)
        
        let visitor = HarmonizeFileVisitor(sourceFile: self)
        
        self.declarations = visitor.declarations
        self.rootDeclarations = visitor.rootDeclarations
    }
}
