//
//  Harmonizer.swift
//
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation

/// The default Harmonize scope builder implementation.
/// Provides all declarations and files from a given path.
internal struct Harmonizer: Harmonize.Builder {
    private let find = Finder()
    
    private let workingDirectory: URL = try! URLResolver.resolveProjectRootPath()
    private let config: Config = makeDefaultConfig()
    
    private var folder: String?
    private var includingOnly: [String] = []
    private var exclusions: [String] = []
    
    private var filesHolder = HarmonizeFilesHolder()
    
    internal init(
        folder: String? = nil,
        includingOnly: [String] = [],
        exclusions: [String] = []
    ) {
        self.folder = folder
        self.includingOnly = includingOnly
        self.exclusions = exclusions
        self.filesHolder = make()
    }
    
    /// A folder or path builder specifier to target Harmonize.
    ///
    /// - parameter folder: the target folder or path name as string.
    /// - returns: the Builder allowing filtering with `excluding` or Harmonize scope.
    ///
    /// Calling Harmonize.on("path/to/code") will effectivelly allow the work on the given path that must be a directory of the working directory.
    /// Additionally it is also possible to call Harmonize.on("Folder") and it will act on every directory it finds with the given name.
    ///
    func on(_ folder: String) -> Harmonize.FolderFilteringBuilder {
        return Self(folder: folder, includingOnly: includingOnly, exclusions: exclusions)
    }
    
    /// Allow exclusion of paths or files of the current Harmonize scope.
    ///
    /// - parameter excludes: the target folder, file.
    /// - returns: Harmonize scope.
    ///
    func excluding(_ excludes: String...) -> HarmonizeScope {
        Self(folder: folder, includingOnly: includingOnly, exclusions: self.exclusions + excludes)
    }
    
    func classes(includeNested: Bool) -> [Class] {
        declarations(includeNested: includeNested).as(Class.self)
    }
    
    func declarations(includeNested: Bool) -> [Declaration] {
        includeNested ? filesHolder.declarations : filesHolder.rootDeclarations
    }
    
    func enums(includeNested: Bool) -> [Enum] {
        declarations(includeNested: includeNested).as(Enum.self)
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
    
    func imports() -> [Import] {
        declarations(includeNested: false).as(Import.self)
    }
    
    func initializers() -> [Initializer] {
        declarations(includeNested: true).as(Initializer.self)
    }
    
    func properties(includeNested: Bool) -> [Property] {
        declarations(includeNested: includeNested).as(Property.self)
    }
    
    func protocols(includeNested: Bool) -> [ProtocolDeclaration] {
        declarations(includeNested: includeNested).as(ProtocolDeclaration.self)
    }
    
    func structs(includeNested: Bool) -> [Struct] {
        declarations(includeNested: includeNested).as(Struct.self)
    }
    
    private func make() -> HarmonizeFilesHolder {
        let files = find(
            workingDirectory: workingDirectory,
            folder: folder,
            inclusions: includingOnly,
            exclusions: config.excludePaths + exclusions
        )
        
        return HarmonizeFilesHolder(
            swiftFiles: files,
            declarations: files.flatMap { $0.declarations },
            rootDeclarations: files.flatMap { $0.rootDeclarations }
        )
    }
    
    private static func makeDefaultConfig() -> Config {
        let configFilePath = try! URLResolver.resolveConfigFilePath()
        let content = try! String(contentsOfFile: configFilePath.path)
        return try! Config(content)
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
