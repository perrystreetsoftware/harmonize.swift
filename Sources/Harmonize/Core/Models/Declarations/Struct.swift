import Foundation

public struct Struct: Declaration,
                      NamedDeclaration,
                      ParentDeclarationProviding,
                      ChildDeclarationsProviding,
                      ClassesProviding,
                      ProtocolsProviding,
                      EnumsProviding,
                      StructsProviding,
                      FileSourceProviding,
                      InheritanceProviding,
                      VariablesProviding,
                      AttributesProviding,
                      ModifiersProviding,
                      FunctionsProviding,
                      InitializersProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration? = nil
    
    public var children: [Declaration] = []
    
    public var swiftFile: SwiftFile
    
    public var inheritanceTypesNames: [String]
    
    public var attributes: [Attribute]
    
    public var modifiers: [Modifier]
    
    public var classes: [Class] {
        children.as(Class.self)
    }
    
    public var enums: [Enum] {
        children.as(Enum.self)
    }
    
    public var structs: [Struct] {
        children.as(Struct.self)
    }
    
    public var protocols: [ProtocolDeclaration] {
        children.as(ProtocolDeclaration.self)
    }
    
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
