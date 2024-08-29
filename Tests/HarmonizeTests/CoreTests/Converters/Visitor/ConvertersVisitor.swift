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
    var attributeConverter = AttributeSyntaxConverter()
    var modifierConverter = DeclModifierSyntaxConverter()

    var attributes = [SwiftAttribute]()
    var modifiers = [SwiftModifier]()
    var types = [SwiftTypeAnnotation]()
    var identifiers = [SwiftIdentifier]()
    var initializers = [SwiftInitializerClause]()
    
    override func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
        attributes.append(contentsOf: attributeConverter.convert(node))
        return .skipChildren
    }
    
    override func visit(_ node: DeclModifierListSyntax) -> SyntaxVisitorContinueKind {
        modifiers.append(contentsOf: modifierConverter.convert(node))
        return .skipChildren
    }
    
    override func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
        let converter = PatternBindingSyntaxConverter(bindings: node)
        identifiers.append(contentsOf: converter.identifiers)
        types.append(contentsOf: converter.types)
        initializers.append(contentsOf: converter.initializers)
        return .skipChildren
    }
}
