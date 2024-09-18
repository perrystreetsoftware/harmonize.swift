//
//  Property+VariableDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 8/31/24.
//

import Foundation
import SwiftSyntax

extension Property {
    static func create(from node: VariableDeclSyntax, file: SwiftFile) -> [Property] {
        let identifiers = node.bindings.names
        let annotations = node.bindings.typeAnnotations
        let initializers = node.bindings.initializerClauses
        let accessors = node.bindings.accessorBlocks
        
        let modifiers = node.modifiers.modifiers
        let attributes = node.attributes.attributes
        
        var properties: [Property] = []
        
        for (index, identifier) in identifiers.enumerated() {
            let annotation = index < annotations.count ? annotations[index] : annotations.last
            let initializer = index < initializers.count ? initializers[index] : nil
            
            let variable = Property(
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
