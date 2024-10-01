//
//  Variable+VariableDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 8/31/24.
//

import Foundation
import SwiftSyntax

extension Variable {
    static func create(from node: VariableDeclSyntax, file: SwiftFile) -> [Variable] {
        let identifiers = node.bindings.names
        let annotations = node.bindings.typeAnnotations
        let initializers = node.bindings.initializerClauses
        let accessors = node.bindings.accessorBlocks
        
        let modifiers = node.modifiers.modifiers
        let attributes = node.attributes.attributes
        
        var properties: [Variable] = []
        
        for (index, identifier) in identifiers.enumerated() {
            let annotation = index < annotations.count ? annotations[index] : annotations.last
            let initializer = index < initializers.count ? initializers[index] : nil
            
            let variable = Variable(
                name: identifier,
                text: node.trimmedDescription,
                swiftFile: file, 
                modifiers: modifiers,
                attributes: attributes,
                accessorBlocks: accessors,
                typeAnnotation: annotation,
                initializerClause: initializer,
                isConstant: node.bindingSpecifier.text == "let"
            )
            
            properties.append(variable)
        }
        
        return properties
    }
}
