//
//  Extension.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Extension: Declaration {
    internal var node: ExtensionDeclSyntax
    
    public let parent: Declaration?
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - Providers

extension Extension: AttributesProviding,
                     DeclarationsProviding,
                     InheritanceProviding,
                     ModifiersProviding,
                     ParentDeclarationProviding,
                     ClassesProviding,
                     ProtocolsProviding,
                     EnumsProviding,
                     StructsProviding,
                     VariablesProviding,
                     FunctionsProviding,
                     InitializersProviding,
                     TypeProviding {
    public var attributes: [Attribute] {
        node.attributes.attributes
    }
    
    public var inheritanceTypesNames: [String] {
        node.inheritanceClause?.toString() ?? []
    }
    
    public var modifiers: [Modifier] {
        node.modifiers.modifiers
    }
    
    public var typeAnnotation: TypeAnnotation? {
        TypeAnnotation(node.extendedType)
    }
    
    public var declarations: [Declaration] {
        DeclarationsCache.shared.declarations(from: node)
    }

    public var classes: [Class] {
        declarations.as(Class.self)
    }
    
    public var enums: [Enum] {
        declarations.as(Enum.self)
    }
    
    public var structs: [Struct] {
        declarations.as(Struct.self)
    }
    
    public var protocols: [ProtocolDeclaration] {
        declarations.as(ProtocolDeclaration.self)
    }
    
    public var variables: [Variable] {
        declarations.as(Variable.self)
    }
    
    public var functions: [Function] {
        declarations.as(Function.self)
    }
    
    public var initializers: [Initializer] {
        declarations.as(Initializer.self)
    }
}

// MARK: - SyntaxNodeProviding

extension Extension: SyntaxNodeProviding {
    init(_ node: ExtensionDeclSyntax) {
        self.init(node: node, parent: nil)
    }
}
