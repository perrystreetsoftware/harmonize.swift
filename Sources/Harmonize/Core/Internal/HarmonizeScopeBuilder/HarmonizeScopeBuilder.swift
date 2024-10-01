//
//  HarmonizeScopeBuilder.swift
//
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation

/// The default Harmonize scope builder implementation.
/// Provides all declarations and files from a given path.
internal class HarmonizeScopeBuilder: On, Excluding {
    private let file: StaticString
    private let findSwiftFiles: FindSwiftFiles
    
    private var folder: String?
    private var includingOnly: [String] = []
    private var exclusions: [String] = []
    
    private lazy var filesHolder = { make() }()
    
    internal init(
        file: StaticString,
        folder: String? = nil,
        includingOnly: [String] = [],
        exclusions: [String] = []
    ) {
        self.file = file
        self.findSwiftFiles = FindSwiftFiles(file)
        self.folder = folder
        self.includingOnly = includingOnly
        self.exclusions = exclusions
    }
    
    // MARK: Builders
    func on(_ folder: String) -> Excluding {
        self.folder = folder
        return self
    }
    
    func excluding(_ excludes: String...) -> HarmonizeScope {
        self.exclusions = excludes + exclusions
        return self
    }
    
    // MARK: -
    
    // MARK: Harmonize Scope
    func classes(includeNested: Bool) -> [Class] {
        declarations(includeNested: includeNested).as(Class.self)
    }
    
    func classes() -> [Class] {
        classes(includeNested: false)
    }
    
    func declarations(includeNested: Bool) -> [Declaration] {
        includeNested ? filesHolder.declarations : filesHolder.rootDeclarations
    }
    
    func declarations() -> [Declaration] {
        declarations(includeNested: false)
    }
    
    func enums(includeNested: Bool) -> [Enum] {
        declarations(includeNested: includeNested).as(Enum.self)
    }
    
    func enums() -> [Enum] {
        enums(includeNested: false)
    }
    
    func extensions() -> [Extension] {
        declarations(includeNested: false).as(Extension.self)
    }
    
    func files() -> [SwiftFile] {
        filesHolder.swiftFiles
    }
    
    func functions(includeNested: Bool) -> [Function] {
        declarations(includeNested: includeNested).as(Function.self)
    }
    
    func functions() -> [Function] {
        functions(includeNested: false)
    }
    
    func imports() -> [Import] {
        declarations(includeNested: false).as(Import.self)
    }
    
    func initializers() -> [Initializer] {
        declarations(includeNested: true).as(Initializer.self)
    }
    
    func variables(includeNested: Bool) -> [Variable] {
        declarations(includeNested: includeNested).as(Variable.self)
    }
    
    func variables() -> [Variable] {
        variables(includeNested: false)
    }
    
    func protocols(includeNested: Bool) -> [ProtocolDeclaration] {
        declarations(includeNested: includeNested).as(ProtocolDeclaration.self)
    }
    
    func protocols() -> [ProtocolDeclaration] {
        protocols(includeNested: false)
    }
    
    func structs(includeNested: Bool) -> [Struct] {
        declarations(includeNested: includeNested).as(Struct.self)
    }
    
    func structs() -> [Struct] {
        structs(includeNested: false)
    }
    
    // MARK: -
    
    private func make() -> HarmonizeFilesHolder {
        let files = findSwiftFiles(
            folder: folder,
            inclusions: includingOnly,
            exclusions: exclusions
        )
        
        return HarmonizeFilesHolder(
            swiftFiles: files,
            declarations: files.flatMap { $0.declarations },
            rootDeclarations: files.flatMap { $0.rootDeclarations }
        )
    }
}

internal struct HarmonizeFilesHolder {
    let swiftFiles: [SwiftFile]
    let declarations: [Declaration]
    let rootDeclarations: [Declaration]
    
    init(
        swiftFiles: [SwiftFile] = [],
        declarations: [Declaration] = [],
        rootDeclarations: [Declaration] = []
    ) {
        self.swiftFiles = swiftFiles
        self.declarations = declarations
        self.rootDeclarations = rootDeclarations
    }
}
