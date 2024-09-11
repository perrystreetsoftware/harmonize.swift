import Foundation

/// Represents a scope in which contains a bunch of files containing declarations to be harmonized.
public protocol HarmonizeScope {
    /// A collection of swift `class` declarations.
    /// - parameter includeNested: if true classes declarations within another declaration are included. Defaults to true.
    /// - returns: the classes.
    func classes(includeNested: Bool) -> [Class]
    
    /// A collection of swift declarations including nested.
    /// - parameter includeNested: if true declarations within another declaration are included. Defaults to true.
    /// - returns: the declarations.
    func declarations(includeNested: Bool) -> [Declaration]
    
    /// A collection of swift `enum` declaration.
    /// - parameter includeNested: if true enum declarations within another declaration are included. Defaults to true.
    /// - returns: the enums.
    func enums(includeNested: Bool) -> [Enum]
    
    /// A collection of swift `extension` declarations.
    /// - returns: the extensions.
    func extensions() -> [Extension]
    
    /// A collection of files found in the given path.
    /// - returns: the files.
    func files() -> [SwiftFile]
    
    /// A collection of swift `func` declarations.
    /// - parameter includeNested: if true function declarations within another declaration are included. Defaults to true.
    /// - returns: the functions.
    func functions(includeNested: Bool) -> [Function]
    
    /// A collection of swift `import` declarations.
    /// - returns: the imports.
    func imports() -> [Import]
    
    /// A collection of swift `init` declarations.
    /// - returns: the initializers.
    func initializers() -> [Initializer]
    
    /// A collection of swift `var` and `let` declaration.
    /// - parameter includeNested: if true variable and constant declarations within another declaration are included, otherwise returns only top-levels declarations. Defaults to true.
    /// - returns: the variables and constants.
    func properties(includeNested: Bool) -> [Property]
    
    /// A collection of swift `protocol` declaration.
    /// - parameter includeNested: if true protocol declarations within another declaration are included. Defaults to true.
    /// - returns: the protocols.
    func protocols(includeNested: Bool) -> [ProtocolDeclaration]
    
    /// A collection of swift `struct` declaration.
    /// - parameter includeNested: if true struct declarations within another declaration are included. Defaults to true.
    /// - returns: the structs.
    func structs(includeNested: Bool) -> [Struct]
}
