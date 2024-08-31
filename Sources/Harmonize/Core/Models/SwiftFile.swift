import Foundation

/// Swift source file containing types such as classes, functions, properties etc.
public struct SwiftFile {
    public let fileName: String

    public let filePath: URL
    
    /// Top-level declarations found in this file, excluding nested declarations.
    public var rootDeclarations: [Declaration] = []
    
    /// Declarations found in this file, including nested declarations.
    public var declarations: [Declaration] = []
    
    init(url: URL) throws {
        self.filePath = url
        self.fileName = url.lastPathComponent
        
        let visitor = try HarmonizeFileVisitor(sourceFile: self)
        
        self.declarations = visitor.declarations
        self.rootDeclarations = visitor.rootDeclarations
    }
}
