import Foundation

public struct Class: Declaration,
                     FileSourceProviding,
                     InheritanceProviding,
                     PropertiesProviding,
                     AttributesProviding,
                     FunctionsProviding,
                     InitializersProviding {
    public let name: String
    
    public let text: String
    
    public var parent: Declaration?
    
    public let swiftFile: SwiftFile
    
    public let inheritanceTypesNames: [String]
        
    public var children: [Declaration]
    
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
