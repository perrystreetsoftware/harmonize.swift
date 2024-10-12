//
//  ReturnClause.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

/// The representation of a declaration's return clause.
public struct ReturnClause: DeclarationDecoration {
    /// The syntax node representing the return clause in the abstract syntax tree (AST).
    internal var node: ReturnClauseSyntax
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - Providers

extension ReturnClause: TypeProviding {
    /// The type annotation associated with the return clause, if present.
    /// - Returns: A `TypeAnnotation` instance if the return type is available, otherwise `nil`.
    public var typeAnnotation: TypeAnnotation? {
        TypeAnnotation(node: node.type)
    }
}


// MARK: - SyntaxNodeProviding

extension ReturnClause: SyntaxNodeProviding {
    init?(_ node: ReturnClauseSyntax) {
        self.node = node
    }
    
    init?(_ node: ReturnClauseSyntax?) {
        guard let node = node else { return nil }
        self.node = node
    }
}
