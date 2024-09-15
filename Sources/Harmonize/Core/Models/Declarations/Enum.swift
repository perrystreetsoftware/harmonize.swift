//
//  Enum.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public struct Enum: Declaration,
                    NamedDeclaration,
                    ParentDeclarationProviding,
                    ChildrenDeclarationProviding,
                    FileSourceProviding,
                    InheritanceProviding,
                    AttributesProviding,
                    ModifiersProviding,
                    PropertiesProviding,
                    FunctionsProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration? = nil
    
    public var children: [Declaration] = []
    
    public var swiftFile: SwiftFile
    
    public var inheritanceTypesNames: [String]
    
    public var attributes: [Attribute]
    
    public var modifiers: [Modifier]
    
    // A collection of all declared cases of this enum.
    public var cases: [EnumCase] {
        children.as(EnumCase.self)
    }
    
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
