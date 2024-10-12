//
//  AccessorBlock.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

/// The representation of a declaration's `get`, `set`, `willSet` or `didSet` accessors.
public struct AccessorBlock: DeclarationDecoration {
    /// The syntax node representing the attribute in the abstract syntax tree (AST).
    internal var node: AccessorDeclSyntax
    
    public var modifier: Modifier? {
        Modifier(rawValue: node.accessorSpecifier.text)
    }
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - Modifier
public extension AccessorBlock {
    enum Modifier: String, CaseIterable, Equatable {
        case get = "get"
        case set = "set"
        case didSet = "didSet"
        case willSet = "willSet"
    }
}

// MARK: - Providers
extension AccessorBlock: BodyProviding {
    public var body: String? {
        node.body?.statements.toString()
    }
}

// MARK: - SyntaxNodeProviding

extension AccessorBlock: SyntaxNodeProviding {
    init?(_ node: AccessorDeclSyntax) {
        self.node = node
    }
    
    init?(_ node: AccessorDeclSyntax?) {
        guard let node = node else { return nil }
        self.node = node
    }
    
    static func accessors(_ node: AccessorBlockSyntax?) -> [AccessorBlock] {
        guard let node = node else { return [] }
        
        return switch node.accessors {
        case .accessors(let accessors):
            accessors.compactMap { self.init($0) }
        case .getter(_):
            []
        }
    }
}
