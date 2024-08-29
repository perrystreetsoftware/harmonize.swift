import Foundation

/// Swift source file containing types such as classes, functions, properties etc.
public struct SwiftFile {
    public let fileName: String
    
    public let filePath: URL
    
    public var declarations: [SwiftDeclaration] = []
    
    init(url: URL) throws {
        self.filePath = url
        self.fileName = url.lastPathComponent
        
        let visitor = HarmonizeFileVisitor(sourceFile: self)
        declarations = try visitor.declarations()
        print("decl \(declarations.count)")
    }
}
