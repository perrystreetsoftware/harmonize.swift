import Foundation

public struct Harmonize {
    private var files: [SwiftFile] = []
    private let projectPath: URL
    
    public init(projectPath: URL) {
        self.projectPath = projectPath
        self.files = findFiles()
    }
    
    public func declarations() -> [SwiftDeclaration] {
        files.flatMap { $0.declarations }
    }
    
    public func classes(includeNested: Bool = true) -> [SwiftClass] {
        let classes = declarations().as(SwiftClass.self)
        
        if !includeNested {
            return classes
        }
        
        return classes.flatMap(appendingDeclarationChildren)
    }
    
    public func structs(includeNested: Bool = true) -> [SwiftStruct] {
        let structs = declarations().as(SwiftStruct.self)
        
        if !includeNested {
            return structs
        }
        
        return structs.flatMap(appendingDeclarationChildren)
    }
    
    public func protocols(includeNested: Bool = true) -> [SwiftProtocol] {
        let protocols = declarations().as(SwiftProtocol.self)
        
        if !includeNested {
            return protocols
        }
        
        let classesProtocols = classes().flatMap { $0.children.as(SwiftProtocol.self) }
        let structsProtocols = structs().flatMap { $0.children.as(SwiftProtocol.self) }
        
        return protocols + classesProtocols + structsProtocols
    }
    
    public func properties(includeNested: Bool = true) -> [SwiftProperty] {
        let properties = declarations().as(SwiftProperty.self)
        
        if !includeNested {
            return properties
        }
        
        let symbols: [PropertiesProviding] = classes() + structs() + protocols()
        
        return properties + symbols.flatMap { $0.properties }
    }
    
    public func functions(includeNested: Bool = true) -> [SwiftFunction] {
        let functions = declarations().as(SwiftFunction.self)
        
        if !includeNested {
            return functions
        }
        
        let symbols: [FunctionsProviding] = [] // TODO
        
        return functions.flatMap(appendingDeclarationChildren) + symbols.flatMap { $0.functions }
    }
    
    private func appendingDeclarationChildren<T>(
        from declaration: T
    ) -> [T] where T: SwiftDeclaration {
        var declarations: [T] = []
        declarations.append(declaration)
        declarations.append(contentsOf: declaration.children.as(T.self))
        return declarations
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
