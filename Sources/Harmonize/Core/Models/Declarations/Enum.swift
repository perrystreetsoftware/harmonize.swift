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
                    ChildDeclarationsProviding,
                    ClassesProviding,
                    ProtocolsProviding,
                    EnumsProviding,
                    StructsProviding,
                    FileSourceProviding,
                    InheritanceProviding,
                    AttributesProviding,
                    ModifiersProviding,
                    VariablesProviding,
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
