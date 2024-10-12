//
//  Initializer.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Initializer: Declaration {
    internal var node: InitializerDeclSyntax
    
    public let parent: Declaration?
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - Providers

extension Initializer: AttributesProviding,
                       DeclarationsProviding,
                       ModifiersProviding,
                       ParentDeclarationProviding,
                       ParametersProviding,
                       VariablesProviding,
                       FunctionsProviding {
    public var attributes: [Attribute] {
        node.attributes.attributes
    }
    
    public var modifiers: [Modifier] {
        node.modifiers.modifiers
    }
    
    public var declarations: [Declaration] {
        DeclarationsCache.shared.declarations(from: node)
    }
    
    public var parameters: [Parameter] {
        node.signature.parameterClause.parameters.compactMap {
            Parameter($0._syntaxNode, parent: self)
        }
    }
    
    public var variables: [Variable] {
        declarations.as(Variable.self)
    }
    
    public var functions: [Function] {
        declarations.as(Function.self)
    }
}

// MARK: - SyntaxNodeProviding

extension Initializer: SyntaxNodeProviding {
    init(_ node: InitializerDeclSyntax) {
        self.init(node: node, parent: nil)
    }
}
