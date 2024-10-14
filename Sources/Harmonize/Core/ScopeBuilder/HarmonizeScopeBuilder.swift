//
//  HarmonizeScopeBuilder.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics

/// The default Harmonize scope builder implementation.
/// Provides all declarations and files from a given path.
internal class HarmonizeScopeBuilder {
    private let file: StaticString
    private let getFiles: GetFiles
    
    private var folder: String?
    private var includingOnly: [String] = []
    private var exclusions: [String] = []
    
    private lazy var files = {
        getFiles(folder: folder, inclusions: includingOnly, exclusions: exclusions)
    }()
    
    internal init(
        file: StaticString,
        folder: String? = nil,
        includingOnly: [String] = [],
        exclusions: [String] = []
    ) {
        self.file = file
        self.getFiles = GetFiles(file)
        self.folder = folder
        self.includingOnly = includingOnly
        self.exclusions = exclusions
    }
}

// MARK: - On

extension HarmonizeScopeBuilder: On {
    func on(_ folder: String) -> Excluding {
        self.folder = folder
        return self
    }
}

// MARK: - Excluding

extension HarmonizeScopeBuilder: Excluding {
     func excluding(_ excludes: String...) -> HarmonizeScope {
         self.exclusions = excludes + exclusions
         return self
     }
}

// MARK: - HarmonizeScope

extension HarmonizeScopeBuilder: HarmonizeScope {
    func classes(includeNested: Bool) -> [Class] {
        sources().flatMap {
            $0.classes(includeNested: includeNested)
        }
    }
    
    func classes() -> [Class] {
        classes(includeNested: false)
    }
    
    func enums(includeNested: Bool) -> [Enum] {
        sources().flatMap {
            $0.enums(includeNested: includeNested)
        }
    }
    
    func enums() -> [Enum] {
        enums(includeNested: false)
    }
    
    func extensions() -> [Extension] {
        sources().flatMap { $0.extensions() }
    }
    
    func sources() -> [SwiftSourceCode] {
        files
    }
    
    func functions(includeNested: Bool) -> [Function] {
        sources().flatMap { $0.functions(includeNested: includeNested) }
    }
    
    func functions() -> [Function] {
        functions(includeNested: false)
    }
    
    func imports() -> [Import] {
        sources().flatMap { $0.imports() }
    }
    
    func initializers() -> [Initializer] {
        sources().flatMap { $0.initializers() }
    }
    
    func variables(includeNested: Bool) -> [Variable] {
        sources().flatMap { $0.variables(includeNested: includeNested )}
    }
    
    func variables() -> [Variable] {
        variables(includeNested: false)
    }
    
    func protocols(includeNested: Bool) -> [ProtocolDeclaration] {
        sources().flatMap { $0.protocols(includeNested: includeNested )}
    }
    
    func protocols() -> [ProtocolDeclaration] {
        protocols(includeNested: false)
    }
    
    func structs(includeNested: Bool) -> [Struct] {
        sources().flatMap { $0.structs(includeNested: includeNested )}

    }
    
    func structs() -> [Struct] {
        structs(includeNested: false)
    }
}
