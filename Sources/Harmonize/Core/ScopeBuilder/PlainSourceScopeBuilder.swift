//
//  PlainSourceScopeBuilder.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/11/24.
//

import HarmonizeSemantics

/// The Harmonize scope builder implementation that parses plain source code over `.swift` files.
internal class PlainSourceScopeBuilder {
    private let sourceCode: SwiftSourceCode
    
    internal init(source: String) {
        self.sourceCode = SwiftSourceCode(source: source)
    }
}

// MARK: - HarmonizeScope

extension PlainSourceScopeBuilder: HarmonizeScope {
    func classes(includeNested: Bool) -> [Class] {
        sourceCode.classes(includeNested: includeNested)
    }
    
    func classes() -> [Class] {
        classes(includeNested: false)
    }
    
    func enums(includeNested: Bool) -> [Enum] {
        sourceCode.enums(includeNested: includeNested)
    }
    
    func enums() -> [Enum] {
        enums(includeNested: false)
    }
    
    func extensions() -> [Extension] {
        sourceCode.extensions()
    }
    
    func sources() -> [SwiftSourceCode] {
        [sourceCode]
    }
    
    func functions(includeNested: Bool) -> [Function] {
        sourceCode.functions(includeNested: includeNested)
    }
    
    func functions() -> [Function] {
        functions(includeNested: false)
    }
    
    func imports() -> [Import] {
        sourceCode.imports()
    }
    
    func initializers() -> [Initializer] {
        sourceCode.initializers()
    }
    
    func variables(includeNested: Bool) -> [Variable] {
        sourceCode.variables(includeNested: includeNested)
    }
    
    func variables() -> [Variable] {
        variables(includeNested: false)
    }
    
    func protocols(includeNested: Bool) -> [ProtocolDeclaration] {
        sourceCode.protocols(includeNested: includeNested)
    }
    
    func protocols() -> [ProtocolDeclaration] {
        protocols(includeNested: false)
    }
    
    func structs(includeNested: Bool) -> [Struct] {
        sourceCode.structs(includeNested: includeNested)
    }
    
    func structs() -> [Struct] {
        structs(includeNested: false)
    }
}
