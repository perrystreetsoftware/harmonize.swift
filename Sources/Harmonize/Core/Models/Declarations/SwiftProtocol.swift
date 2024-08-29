import Foundation

public struct SwiftProtocol: SwiftDeclaration,
                             FileSourceProviding,
                             InheritanceProviding,
                             PropertiesProviding,
                             AttributesProviding,
                             FunctionsProviding,
                             InitializersProviding {
    public let name: String
    
    public let text: String
    
    public var parent: SwiftDeclaration?
    
    public let swiftFile: SwiftFile
    
    public let inheritanceTypesNames: [String]
        
    public var children: [SwiftDeclaration]
    
    public var attributes: [SwiftAttribute]
    
    public var properties: [SwiftProperty] {
        children.as(SwiftProperty.self)
    }
    
    public var functions: [SwiftFunction] {
        children.as(SwiftFunction.self)
    }
    
    public var initializers: [SwiftInitializer] {
        children.as(SwiftInitializer.self)
    }
}
