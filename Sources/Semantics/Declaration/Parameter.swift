//
//  Parameter.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Parameter: Declaration {
    internal var node: Syntax
    
    public let parent: Declaration?
    
    public var description: String {
        node.trimmedDescription
    }
    
    /// Indicates whether the parameter is variadic, meaning it accepts a variable number of arguments.
    /// A variadic parameter is one that ends with an ellipsis (`...`), allowing the function to accept
    /// multiple value for the parameter.
    ///
    /// - Returns: `true` if the parameter is variadic, allowing multiple arguments; otherwise, `false`.
    public var isVariadic: Bool {
        functionParameter?.ellipsis != nil
    }
    
    private init(node: Syntax, parent: Declaration?) {
        self.node = node
        self.parent = parent
    }
}

// MARK: - Providers

extension Parameter: NamedDeclaration,
                     AttributesProviding,
                     ModifiersProviding,
                     ParentDeclarationProviding,
                     TypeProviding,
                     InitializerClauseProviding {
    private var functionParameter: FunctionParameterSyntax? {
        node.as(FunctionParameterSyntax.self)
    }
    
    private var enumCaseParameter: EnumCaseParameterSyntax? {
        node.as(EnumCaseParameterSyntax.self)
    }
    
    public var attributes: [Attribute] {
        node.typeAttributes + (functionParameter?.attributes.attributes ?? [])
    }
    
    public var modifiers: [Modifier] {
        functionParameter?.modifiers.modifiers ?? []
    }
    
    public var name: String {
        node.name
    }
    
    public var label: String {
        node.label
    }
    
    public var typeAnnotation: TypeAnnotation? {
        TypeAnnotation(functionParameter?.type ?? enumCaseParameter?.type)
    }
    
    public var initializerClause: InitializerClause? {
        let value = functionParameter?.defaultValue ?? enumCaseParameter?.defaultValue
        return value?.initializerClause
    }
}

// MARK: - SyntaxNodeProviding

extension Parameter: SyntaxNodeProviding {
    init?(_ node: Syntax) {
        self.init(node: node, parent: nil)
    }
    
    init?(_ node: Syntax, parent: Declaration?) {
        self.parent = parent
        
        if let node = node.as(FunctionParameterSyntax.self) {
            self.node = node._syntaxNode
            return
        }
        
        if let node = node.as(EnumCaseParameterSyntax.self) {
            self.node = node._syntaxNode
            return
        }
        
        return nil
    }
}

fileprivate extension Syntax {
    var name: String {
        guard let node = self.as(FunctionParameterSyntax.self) else { return "" }
        return node.secondName?.text ?? node.firstName.text
    }
    
    var label: String {
        if let node = self.as(FunctionParameterSyntax.self) {
            return node.firstName.text
        }
        
        if let node = self.as(EnumCaseParameterSyntax.self) {
            let label = [node.firstName?.text, node.secondName?.text]
                .compactMap { $0 }
                .joined(separator: " ")
            
            return label
        }
        
        return ""
    }
    
    var typeAttributes: [Attribute] {
        if let node = self.as(FunctionParameterSyntax.self),
           let type = node.type.as(AttributedTypeSyntax.self) {
            return type.attributes.attributes
        }
        
        if let node = self.as(EnumCaseParameterSyntax.self),
           let type = node.type.as(AttributedTypeSyntax.self) {
            return type.attributes.attributes
        }
        
        return []
    }
}
