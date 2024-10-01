import Foundation

/// Represents a scope in which contains a bunch of files containing declarations to be harmonized.
public protocol HarmonizeScope {
    /// A collection of ``class`` declarations.
    /// - parameter includeNested: if true classes declarations within another declaration are included.
    /// - returns: the classes.
    func classes(includeNested: Bool) -> [Class]
    
    /// A collection of top-level``class`` declarations.
    /// - returns: the classes.
    func classes() -> [Class]
    
    /// A collection of swift declarations including nested.
    /// - parameter includeNested: if true declarations within another declaration are included.
    /// - returns: the declarations.
    func declarations(includeNested: Bool) -> [Declaration]
    
    /// A collection of top-level declarations.
    /// - returns: the declarations.
    func declarations() -> [Declaration]
    
    /// A collection of ``enum`` declarations.
    /// - parameter includeNested: if true enum declarations within another declaration are included.
    /// - returns: the enums.
    func enums(includeNested: Bool) -> [Enum]
    
    /// A collection of  top-level``enum`` declarations.
    /// - returns: the enums.
    func enums() -> [Enum]
    
    /// A collection of ``extension`` declarations.
    /// - returns: the extensions.
    func extensions() -> [Extension]
    
    /// A collection of files found in this scope.
    /// - returns: the files.
    func files() -> [SwiftFile]
    
    /// A collection of ``func`` declarations.
    /// - parameter includeNested: if true function declarations within another declaration are included.
    /// - returns: the functions.
    func functions(includeNested: Bool) -> [Function]
    
    /// A collection of top-level ``func`` declarations.
    /// - returns: the functions.
    func functions() -> [Function]
    
    /// A collection of swift `import` declarations.
    /// - returns: the imports.
    func imports() -> [Import]
    
    /// A collection of ``init`` declarations.
    /// - returns: the initializers.
    func initializers() -> [Initializer]
    
    /// A collection of swift `var` and `let` declaration.
    /// - parameter includeNested: if true variable and constant declarations within another declaration are included, otherwise returns only top-levels declarations.
    /// - returns: the variables and constants.
    func variables(includeNested: Bool) -> [Variable]
    
    /// A collection of ``var`` and ``let`` declaration.
    /// - returns: the variables and constants.
    func variables() -> [Variable]
    
    /// A collection of ``protocol`` declaration.
    /// - parameter includeNested: if true protocol declarations within another declaration are included.
    /// - returns: the protocols.
    func protocols(includeNested: Bool) -> [ProtocolDeclaration]
    
    /// A collection of ``protocol`` declaration.
    /// - returns: the protocols.
    func protocols() -> [ProtocolDeclaration]
    
    /// A collection of swift `struct` declaration.
    /// - parameter includeNested: if true struct declarations within another declaration are included.
    /// - returns: the structs.
    func structs(includeNested: Bool) -> [Struct]
    
    /// A collection of ``struct`` declaration.
    /// - returns: the structs.
    func structs() -> [Struct]
}
