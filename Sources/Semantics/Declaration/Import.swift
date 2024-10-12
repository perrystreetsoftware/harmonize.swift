//
//  Import.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Import: Declaration {
    internal var node: ImportDeclSyntax
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - ImportKind
public extension Import {
    enum ImportKind: String {
        case `typealias`, `struct`, `class`, `enum`, `protocol`, `let`, `var`, `func`
    }
}

// MARK: - Providers

extension Import: NamedDeclaration,
                  AttributesProviding {
    public var attributes: [Attribute] {
        node.attributes.attributes
    }
    
    public var name: String {
        node.path.map { $0.name.text }.joined(separator: ".")
    }
    
    public var kind: ImportKind? {
        ImportKind(rawValue: node.importKindSpecifier?.text ?? "")
    }
}

// MARK: - SyntaxNodeProviding

extension Import: SyntaxNodeProviding {
    init(_ node: ImportDeclSyntax) {
        self.node = node
    }
}
