import Foundation

public struct Struct: Declaration,
                      NamedDeclaration,
                      ParentDeclarationProviding,
                      ChildrenDeclarationProviding,
                      FileSourceProviding,
                      InheritanceProviding,
                      PropertiesProviding,
                      AttributesProviding,
                      FunctionsProviding,
                      InitializersProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration? = nil
    
    public var children: [Declaration] = []
    
    public var swiftFile: SwiftFile
    
    public var inheritanceTypesNames: [String]
    
    public var attributes: [Attribute]
    
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
