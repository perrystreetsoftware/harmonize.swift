//
//  ProtocolDeclaration.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct ProtocolDeclaration: Declaration {
    internal var node: ProtocolDeclSyntax
    
    public let parent: Declaration?
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - Providers

extension ProtocolDeclaration: NamedDeclaration,
                               AttributesProviding,
                               DeclarationsProviding,
                               ParentDeclarationProviding,
                               ModifiersProviding,
                               VariablesProviding,
                               FunctionsProviding,
                               InitializersProviding,
                               InheritanceProviding {
    public var attributes: [Attribute] {
        node.attributes.attributes
    }
    
    public var modifiers: [Modifier] {
        node.modifiers.modifiers
    }
    
    public var name: String {
        node.name.text
    }
    
    public var declarations: [Declaration] {
        DeclarationsCache.shared.declarations(from: node)
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
    
    public var inheritanceTypesNames: [String] {
        node.inheritanceClause?.toString() ?? []
    }
}

// MARK: - SyntaxNodeProviding

extension ProtocolDeclaration: SyntaxNodeProviding {
    init(_ node: ProtocolDeclSyntax) {
        self.init(node: node, parent: nil)
    }
}
