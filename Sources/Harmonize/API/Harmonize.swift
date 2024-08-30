import Foundation

public struct Harmonize {
    private var files: [SwiftFile] = []
    private let projectPath: URL
    private var declarations: [SwiftDeclaration] = []
    private var rootDeclarations: [SwiftDeclaration] = []
    
    public init(projectPath: URL) {
        self.projectPath = projectPath
        self.files = findFiles()
        
        self.declarations = files.flatMap { $0.declarations }
        self.rootDeclarations = files.flatMap { $0.rootDeclarations }
    }
    
    public func declarations(includeNested: Bool = true) -> [SwiftDeclaration] {
        includeNested ? declarations : rootDeclarations
    }
    
    public func classes(includeNested: Bool = true) -> [SwiftClass] {
        declarations(includeNested: includeNested).as(SwiftClass.self)
    }
    
    public func structs(includeNested: Bool = true) -> [SwiftStruct] {
        declarations(includeNested: includeNested).as(SwiftStruct.self)
    }
    
    public func protocols(includeNested: Bool = true) -> [SwiftProtocol] {
        declarations(includeNested: includeNested).as(SwiftProtocol.self)
    }
    
    public func properties(includeNested: Bool = true) -> [SwiftProperty] {
        declarations(includeNested: includeNested).as(SwiftProperty.self)
    }
    
    public func functions(includeNested: Bool = true) -> [SwiftFunction] {
        declarations(includeNested: includeNested).as(SwiftFunction.self)
    }
    
    public func initializers() -> [SwiftInitializer] {
        declarations().as(SwiftInitializer.self)
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
