//
//  AccessorBlock.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

/// The representation of a computed-property getter block.
public struct GetterBlock: DeclarationDecoration {
    internal var node: CodeBlockItemListSyntax
    
    public var description: String {
        node.trimmedDescription
    }
}

// MARK: - BodyProviding

extension GetterBlock: BodyProviding {
    public var body: String? {
        node.toString()
    }
}

// MARK: - SyntaxNodeProviding

extension GetterBlock: SyntaxNodeProviding {
    init?(_ node: CodeBlockItemListSyntax) {
        self.node = node
    }
    
    init?(_ node: CodeBlockItemListSyntax?) {
        guard let node = node else { return nil }
        self.node = node
    }
    
    static func getter(_ node: AccessorBlockSyntax?) -> GetterBlock? {
        guard let node = node else { return nil }
        
        return switch node.accessors {
        case .accessors(_):
            nil
        case .getter(let block):
            self.init(block)
        }
    }
}
