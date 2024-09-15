//
//  Extension.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public struct Extension: Declaration,
                         ChildrenDeclarationProviding,
                         FileSourceProviding,
                         InheritanceProviding,
                         PropertiesProviding,
                         ModifiersProviding,
                         AttributesProviding,
                         FunctionsProviding,
                         InitializersProviding {
    public var text: String
    
    public var children: [Declaration] = []
    
    public var swiftFile: SwiftFile
    
    public var inheritanceTypesNames: [String]
    
    public var attributes: [Attribute]
    
    public var modifiers: [Modifier]
    
    /// The extension's target type name.
    public var extendedTypeName: String
    
    public var genericWhereClause: String?
    
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
