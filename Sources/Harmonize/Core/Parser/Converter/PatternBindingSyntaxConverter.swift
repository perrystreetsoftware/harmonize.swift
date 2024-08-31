//
//  PatternBindingSyntaxConverter.swift
//
//
//  Created by Lucas Cavalcante on 8/25/24.
//

import Foundation
import SwiftSyntax

class PatternBindingSyntaxConverter {
    private let initializerConverter: InitializerClauseSyntaxConverter = InitializerClauseSyntaxConverter()
    private let bindings: PatternBindingListSyntax
    
    private(set) var identifiers: [Identifier] = []
    private(set) var types: [TypeAnnotation] = []
    private(set) var initializers: [InitializerClause] = []
    private(set) var accessors: [Accessor] = []
    
    init(bindings: PatternBindingListSyntax) {
        self.bindings = bindings
        bindings.forEach { binding in
            identifiers.append(getIdentifier(for: binding.pattern))
            
            if let type = getTypeAnnotation(for: binding.typeAnnotation) {
                types.append(type)
            }
            
            if let initializer = getInitializer(for: binding.initializer) {
                initializers.append(initializer)
            }
            
            self.accessors.append(contentsOf: getAccessors(for: binding.accessorBlock))
        }
    }
    
    private func getIdentifier(for pattern: PatternSyntax) -> Identifier {
        return Identifier(name: pattern.trimmedDescription)
    }
    
    private func getInitializer(for initializer: InitializerClauseSyntax?) -> InitializerClause? {
        initializerConverter.convert(initializer)
    }
    
    private func getTypeAnnotation(for annotation: TypeAnnotationSyntax?) -> TypeAnnotation? {
        guard let annotation = annotation else { return nil }
        return TypeAnnotation(
            name: annotation.type.trimmedDescription,
            isOptional: annotation.type.is(OptionalTypeSyntax.self)
        )
    }
    
    private func getAccessors(for node: AccessorBlockSyntax?) -> [Accessor] {
        guard let node = node else { return [] }
        
        return switch node.accessors {
        case .accessors(let accessors):
            accessors.compactMap {
                guard let modifier = Accessor.Modifier.from(identifier: $0.accessorSpecifier.text)
                else { return nil }
                
                return Accessor(
                    modifier: modifier,
                    body: getCodeBlockStatementsAsString(statements: $0.body?.statements)
                )
            }
        case .getter(let codeBlock):
            [
                Accessor(
                    modifier: .getter,
                    body: getCodeBlockStatementsAsString(statements: codeBlock)
                )
            ]
        @unknown default:
            []
        }
    }
    
    private func getCodeBlockStatementsAsString(statements: CodeBlockItemListSyntax?) -> String? {
        guard let statements = statements else { return nil }
        return statements.compactMap {
            return if let value = $0.item.as(StringLiteralExprSyntax.self) {
                value.representedLiteralValue
            } else {
                $0.trimmedDescription
            }
        }.joined()
    }
}
