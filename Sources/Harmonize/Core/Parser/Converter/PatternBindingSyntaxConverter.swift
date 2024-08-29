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
    
    private(set) var identifiers: [SwiftIdentifier] = []
    private(set) var types: [SwiftTypeAnnotation] = []
    private(set) var initializers: [SwiftInitializerClause] = []
    
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
        }
    }
    
    private func getIdentifier(for pattern: PatternSyntax) -> SwiftIdentifier {
        return SwiftIdentifier(name: pattern.trimmedDescription)
    }
    
    private func getInitializer(for initializer: InitializerClauseSyntax?) -> SwiftInitializerClause? {
        initializerConverter.convert(initializer)
    }
    
    private func getTypeAnnotation(for annotation: TypeAnnotationSyntax?) -> SwiftTypeAnnotation? {
        guard let annotation = annotation else { return nil }
        return SwiftTypeAnnotation(
            name: annotation.type.trimmedDescription,
            isOptional: annotation.type.is(OptionalTypeSyntax.self)
        )
    }
}
