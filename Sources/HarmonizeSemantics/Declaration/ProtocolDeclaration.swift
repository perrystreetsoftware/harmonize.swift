//
//  ProtocolDeclaration.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct ProtocolDeclaration: Declaration, SyntaxNodeProviding {
    public let node: ProtocolDeclSyntax
    
    public let parent: Declaration?

    public let sourceCodeLocation: SourceCodeLocation
    
    public var description: String {
        node.trimmedDescription
    }
    
    internal init(
        node: ProtocolDeclSyntax,
        parent: Declaration?,
        sourceCodeLocation: SourceCodeLocation
    ) {
        self.node = node
        self.parent = parent
        self.sourceCodeLocation = sourceCodeLocation
    }
}

// MARK: - Capabilities Comformance

extension ProtocolDeclaration: NamedDeclaration,
                               AttributesProviding,
                               DeclarationsProviding,
                               ParentDeclarationProviding,
                               ModifiersProviding,
                               VariablesProviding,
                               FunctionsProviding,
                               InitializersProviding,
                               InheritanceProviding,
                               SourceCodeProviding {
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
