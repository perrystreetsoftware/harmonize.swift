//
//  ReturnClause.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

/// The representation of a declaration's return clause.
public struct ReturnClause: DeclarationDecoration, SyntaxNodeProviding {
    /// The syntax node representing the return clause in the abstract syntax tree (AST).
    public let node: ReturnClauseSyntax
    
    public var description: String {
        node.trimmedDescription
    }
    
    internal init(node: ReturnClauseSyntax) {
        self.node = node
    }
    
    internal init?(node: ReturnClauseSyntax?) {
        guard let node = node else { return nil }
        self.node = node
    }
}

// MARK: - TypeProviding Comformance

extension ReturnClause: TypeProviding {
    /// The type annotation associated with the return clause, if present.
    /// - Returns: A `TypeAnnotation` instance if the return type is available, otherwise `nil`.
    public var typeAnnotation: TypeAnnotation? {
        TypeAnnotation(node: node.type)
    }
}
