//
//  Extension.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public struct Extension: Declaration,
                         ChildDeclarationsProviding,
                         ClassesProviding,
                         ProtocolsProviding,
                         EnumsProviding,
                         StructsProviding,
                         FileSourceProviding,
                         InheritanceProviding,
                         VariablesProviding,
                         ModifiersProviding,
                         AttributesProviding,
                         FunctionsProviding,
                         InitializersProviding,
                         TypeAnnotationProviding {
    public var text: String
    
    public var children: [Declaration] = []
    
    public var swiftFile: SwiftFile
    
    public var inheritanceTypesNames: [String]
    
    public var attributes: [Attribute]
    
    public var modifiers: [Modifier]
    
    public var genericWhereClause: String?
    
    public var typeAnnotation: TypeAnnotation?
    
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
