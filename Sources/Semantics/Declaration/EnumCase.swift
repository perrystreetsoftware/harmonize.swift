//
//  EnumCase.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct EnumCase: Declaration, SyntaxNodeProviding {
    internal let parentNode: EnumCaseDeclSyntax
    
    public let node: EnumCaseElementSyntax
    
    public let parent: Declaration?
    
    public let sourceCodeLocation: SourceCodeLocation
    
    public var description: String {
        node.trimmedDescription
    }
    
    internal init(
        parentNode: EnumCaseDeclSyntax,
        node: EnumCaseElementSyntax,
        parent: Declaration?,
        sourceCodeLocation: SourceCodeLocation
    ) {
        self.parentNode = parentNode
        self.node = node
        self.parent = parent
        self.sourceCodeLocation = sourceCodeLocation
    }
}

// MARK: - Capabilities Comformance

extension EnumCase: NamedDeclaration,
                    AttributesProviding,
                    ModifiersProviding,
                    ParentDeclarationProviding,
                    InitializerClauseProviding,
                    ParametersProviding,
                    SourceCodeProviding {
    public var attributes: [Attribute] {
        parentNode.attributes.attributes
    }
    
    public var modifiers: [Modifier] {
        parentNode.modifiers.modifiers
    }
    
    public var name: String {
        node.name.text
    }
    
    public var initializerClause: InitializerClause? {
        node.rawValue?.initializerClause
    }
    
    public var parameters: [Parameter] {
        node.parameterClause?.parameters.compactMap {
            Parameter(
                node: $0._syntaxNode,
                parent: parent,
                sourceCodeLocation: sourceCodeLocation
            )
        } ?? []
    }
}

// MARK: - EnumCase Factory

extension EnumCase {
    static func cases(
        from node: EnumCaseDeclSyntax,
        parent: Declaration?,
        sourceCodeLocation: SourceCodeLocation
    ) -> [EnumCase] {
        node.elements.compactMap {
            Self(
                parentNode: node,
                node: $0,
                parent: parent,
                sourceCodeLocation: sourceCodeLocation
            )
        }
    }
}
