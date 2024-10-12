//  Variable.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Variable: Declaration {
    private var parentNode: VariableDeclSyntax
    
    internal var node: PatternBindingSyntax
    
    public let parent: Declaration?
    
    public var description: String {
        node.trimmedDescription
    }
    
    public var isOptional: Bool {
        typeAnnotation?.isOptional == true
    }
    
    public var isConstant: Bool {
        parentNode.bindingSpecifier.text == "let"
    }
    
    public var isVariable: Bool {
        !isConstant
    }
    
    public var isOfInferredType: Bool {
        typeAnnotation == nil
    }
    
    public var isComputed: Bool {
        getter != nil
    }
    
    public var isStored: Bool {
        !isComputed
    }
}

// MARK: - Providers

extension Variable: NamedDeclaration,
                    AttributesProviding,
                    ModifiersProviding,
                    ParentDeclarationProviding,
                    AccessorBlocksProviding,
                    TypeProviding,
                    InitializerClauseProviding {
    public var attributes: [Attribute] {
        parentNode.attributes.attributes
    }
    
    public var modifiers: [Modifier] {
        parentNode.modifiers.modifiers
    }
    
    public var name: String {
        node.pattern.trimmedDescription
    }
        
    public var typeAnnotation: TypeAnnotation? {
        TypeAnnotation(node.typeAnnotation?.type ?? parentNode.bindings.compactMap { $0.typeAnnotation?.type }.first)
    }
    
    public var initializerClause: InitializerClause? {
        node.initializer?.initializerClause
    }
    
    public var accessors: [AccessorBlock] {
        AccessorBlock.accessors(node.accessorBlock)
    }
    
    public var getter: GetterBlock? {
        GetterBlock.getter(node.accessorBlock)
    }
}

// MARK: - SyntaxNodeProviding

extension Variable: SyntaxNodeProviding {
    init?(_ node: PatternBindingSyntax) {
        self.init(node: node, parent: nil, parentNode: node.parentAs(VariableDeclSyntax.self))
    }
    
    init?(
        node: PatternBindingSyntax,
        parent: Declaration?,
        parentNode: VariableDeclSyntax?
    ) {
        guard let parentNode = parentNode else { return nil }
        self.node = node
        self.parentNode = parentNode
        self.parent = parent
    }
    
    static func variables(from node: VariableDeclSyntax, parent: Declaration?) -> [Variable] {
        node.bindings.compactMap {
            Variable(node: $0, parent: parent, parentNode: node)
        }
    }
}
