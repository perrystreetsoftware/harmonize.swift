import Foundation

public struct Class: Declaration,
                     NamedDeclaration,
                     ParentDeclarationProviding,
                     ChildrenDeclarationProviding,
                     FileSourceProviding,
                     InheritanceProviding,
                     PropertiesProviding,
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
    
    public var properties: [Property] {
        children.as(Property.self)
    }
    
    public var functions: [Function] {
        children.as(Function.self)
    }

    public var initializers: [Initializer] {
        children.as(Initializer.self)
    }
}
