//
//  InitializerClause.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax
import SwiftParser

/// The representation of a declaration's initializer clause.
public struct InitializerClause: DeclarationDecoration {
    /// The syntax node representing the initializer clause in the abstract syntax tree (AST).
    internal var node: InitializerClauseSyntax
    
    /// The value of the initializer clause, representing the content assigned after the `=` sign.
    ///
    /// For example, in the declaration `var prop = "xyz"`, the `value` is `"xyz"`.
    public var value: String {
        let literalValue = node.value.as(StringLiteralExprSyntax.self)?.representedLiteralValue
        return literalValue ?? node.value.trimmedDescription
    }
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - SyntaxNodeProviding

extension InitializerClause: SyntaxNodeProviding {
    init?(_ node: InitializerClauseSyntax) {
        self.node = node
    }
    
    init?(_ node: InitializerClauseSyntax?) {
        guard let node = node else { return nil }
        self.node = node
    }
}
