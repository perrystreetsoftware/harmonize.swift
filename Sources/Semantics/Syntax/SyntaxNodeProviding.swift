//
//  SyntaxNodeProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

/// Protocol which provides the raw syntax node a declaration provides.
internal protocol SyntaxNodeProviding: Equatable, Hashable {
    associatedtype Syntax: SyntaxProtocol

    var node: Syntax { get }
    
    init?(_ node: Syntax)
}

extension SyntaxNodeProviding {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.node.id == rhs.node.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(node.id)
    }
}
