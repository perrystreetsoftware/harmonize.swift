//
//  Function.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Function: Declaration {
    internal var node: FunctionDeclSyntax
    
    public let parent: Declaration?
    
    public var description: String {
        node.trimmedDescription
    }
    
    public var returnClause: ReturnClause? {
        ReturnClause(node.signature.returnClause)
    }
    
    public var genericClause: String? {
        node.genericParameterClause?.trimmedDescription
    }
    
    public var whereClause: String? {
        node.genericWhereClause?.trimmedDescription
    }
}

// MARK: - Providers

extension Function: NamedDeclaration,
                    AttributesProviding,
                    DeclarationsProviding,
                    ModifiersProviding,
                    ParentDeclarationProviding,
                    ClassesProviding,
                    ProtocolsProviding,
                    EnumsProviding,
                    StructsProviding,
                    BodyProviding,
                    ParametersProviding,
                    FunctionsProviding,
                    FunctionCallsProviding {
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
    
    public var functions: [Function] {
        declarations.as(Function.self)
    }
    
    public var parameters: [Parameter] {
        node.signature.parameterClause.parameters.compactMap {
            Parameter($0._syntaxNode, parent: self)
        }
    }
    
    public var body: String? {
        node.body?.statements.toString()
    }
    
    public var functionCalls: [FunctionCall] {
        declarations.as(FunctionCall.self)
    }
}

// MARK: - SyntaxNodeProviding

extension Function: SyntaxNodeProviding {
    init(_ node: FunctionDeclSyntax) {
        self.init(node: node, parent: nil)
    }
}
