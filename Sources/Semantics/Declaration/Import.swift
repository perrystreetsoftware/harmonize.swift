//
//  Import.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

public struct Import: Declaration, SyntaxNodeProviding {
    public let node: ImportDeclSyntax
    
    public let sourceCodeLocation: SourceCodeLocation
    
    public var description: String {
        node.trimmedDescription
    }
    
    internal init(
        node: ImportDeclSyntax,
        sourceCodeLocation: SourceCodeLocation
    ) {
        self.node = node
        self.sourceCodeLocation = sourceCodeLocation
    }
}

// MARK: - ImportKind

public extension Import {
    enum ImportKind: String {
        case `typealias`, `struct`, `class`, `enum`, `protocol`, `let`, `var`, `func`
    }
}

// MARK: - Capabilities Comformance

extension Import: NamedDeclaration,
                  AttributesProviding,
                  SourceCodeProviding {
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
