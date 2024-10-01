import Foundation

public struct ProtocolDeclaration: Declaration,
                                   NamedDeclaration,
                                   ParentDeclarationProviding,
                                   ChildDeclarationsProviding,
                                   FileSourceProviding,
                                   InheritanceProviding,
                                   VariablesProviding,
                                   AttributesProviding,
                                   FunctionsProviding,
                                   ModifiersProviding,
                                   InitializersProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration? = nil
    
    public var children: [Declaration] = []
    
    public var swiftFile: SwiftFile
    
    public var inheritanceTypesNames: [String]
    
    public var attributes: [Attribute]
    
    public var modifiers: [Modifier]
    
    public var variables: [Variable] {
        children.as(Variable.self)
    }
    
    public var functions: [Function] {
        children.as(Function.self)
    }
    
    public var initializers: [Initializer] {
        children.as(Initializer.self)
    }
}
