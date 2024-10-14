//  Variable.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Variable: Declaration, SyntaxNodeProviding {
    private let parentNode: VariableDeclSyntax
    
    public let node: PatternBindingSyntax
    
    public let parent: Declaration?
    
    public let sourceCodeLocation: SourceCodeLocation
    
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
    
    internal init(
        parentNode: VariableDeclSyntax,
        node: PatternBindingSyntax,
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

extension Variable: NamedDeclaration,
                    AttributesProviding,
                    ModifiersProviding,
                    ParentDeclarationProviding,
                    AccessorBlocksProviding,
                    TypeProviding,
                    InitializerClauseProviding,
                    SourceCodeProviding {
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
        let node = node.typeAnnotation?.type ?? parentNode.bindings.compactMap { $0.typeAnnotation?.type }.first
        return TypeAnnotation(node: node)
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

// MARK: - Variables Factory

extension Variable {
    static func variables(
        from node: VariableDeclSyntax,
        parent: Declaration?,
        sourceCodeLocation: SourceCodeLocation
    ) -> [Variable] {
        node.bindings.compactMap {
            Variable(
                parentNode: node,
                node: $0,
                parent: parent,
                sourceCodeLocation: sourceCodeLocation
            )
        }
    }
}
