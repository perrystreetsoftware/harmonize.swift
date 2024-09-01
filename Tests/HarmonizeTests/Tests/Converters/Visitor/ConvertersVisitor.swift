//
//  ConvertersVisitor.swift
//
//
//  Created by Lucas Cavalcante on 8/25/24.
//

import Foundation
import SwiftSyntax
@testable import Harmonize

class ConvertersVisitor: SyntaxVisitor {
    var attributes = [Attribute]()
    var modifiers = [Modifier]()
    var types = [TypeAnnotation]()
    var identifiers = [String]()
    var initializers = [InitializerClause]()
    var accessors = [AccessorBlock]()
    
    override func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
        attributes.append(contentsOf: node.attributes)
        return .skipChildren
    }
    
    override func visit(_ node: DeclModifierListSyntax) -> SyntaxVisitorContinueKind {
        modifiers.append(contentsOf: node.modifiers)
        return .skipChildren
    }
    
    override func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
        identifiers.append(contentsOf: node.names)
        types.append(contentsOf: node.typeAnnotations)
        initializers.append(contentsOf: node.initializerClauses)
        accessors.append(contentsOf: node.accessorBlocks)
        return .skipChildren
    }
}
