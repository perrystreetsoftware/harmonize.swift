//
//  EnumCase.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct EnumCase: Declaration {
    private var parentNode: EnumCaseDeclSyntax
    
    internal var node: EnumCaseElementSyntax
    
    public let parent: Declaration?
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - Providers

extension EnumCase: NamedDeclaration,
                    AttributesProviding,
                    ModifiersProviding,
                    ParentDeclarationProviding,
                    InitializerClauseProviding,
                    ParametersProviding {
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
            Parameter($0._syntaxNode, parent: parent)
        } ?? []
    }
}

// MARK: - SyntaxNodeProviding

extension EnumCase: SyntaxNodeProviding {
    init?(_ node: EnumCaseElementSyntax) {
        self.init(node: node, parent: nil, parentNode: node.parentAs(EnumCaseDeclSyntax.self))
    }
    
    init?(
        node: EnumCaseElementSyntax,
        parent: Declaration?,
        parentNode: EnumCaseDeclSyntax?
    ) {
        guard let parentNode = parentNode else { return nil }
        self.node = node
        self.parentNode = parentNode
        self.parent = parent
    }
    
    static func cases(from node: EnumCaseDeclSyntax, parent: Declaration?) -> [EnumCase] {
        node.elements.compactMap {
            Self(node: $0, parent: parent, parentNode: node)
        }
    }
}
