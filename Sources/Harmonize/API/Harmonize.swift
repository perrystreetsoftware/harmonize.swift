import Foundation

public struct Harmonize {
    private var files: [SwiftFile] = []
    private let projectPath: URL
    private var declarations: [Declaration] = []
    private var rootDeclarations: [Declaration] = []
    
    public init(projectPath: URL) {
        self.projectPath = projectPath
        self.files = findFiles()
        
        self.declarations = files.flatMap { $0.declarations }
        self.rootDeclarations = files.flatMap { $0.rootDeclarations }
    }
    
    public func classes(includeNested: Bool = true) -> [Class] {
        declarations(includeNested: includeNested).as(Class.self)
    }
    
    public func declarations(includeNested: Bool = true) -> [Declaration] {
        includeNested ? declarations : rootDeclarations
    }
    
    public func enums(includeNested: Bool = true) -> [Enum] {
        declarations(includeNested: includeNested).as(Enum.self)
    }
    
    public func functions(includeNested: Bool = true) -> [Function] {
        declarations(includeNested: includeNested).as(Function.self)
    }
    
    public func initializers() -> [Initializer] {
        declarations().as(Initializer.self)
    }
    
    public func properties(includeNested: Bool = true) -> [Property] {
        declarations(includeNested: includeNested).as(Property.self)
    }
    
    public func protocols(includeNested: Bool = true) -> [ProtocolDeclaration] {
        declarations(includeNested: includeNested).as(ProtocolDeclaration.self)
    }
    
    public func structs(includeNested: Bool = true) -> [Struct] {
        declarations(includeNested: includeNested).as(Struct.self)
    }
    
    private func findFiles() -> [SwiftFile] {
        let files = FileManager.default
            .enumerator(at: projectPath, includingPropertiesForKeys: nil)?
            .compactMap { $0 as? URL }
            .filter { $0.hasDirectoryPath == false }
            .filter { $0.pathExtension == "swift" } ?? []
        
        return files.compactMap { try? SwiftFile(url: $0) }
    }
}
