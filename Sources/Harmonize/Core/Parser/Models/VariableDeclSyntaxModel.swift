//
//  VariableDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 8/31/24.
//

import Foundation
import SwiftSyntax

struct VariableDeclSyntaxModel: Property {
    var name: String
    
    var text: String
    
    var parent: Declaration?
    
    var children: [Declaration] = []
    
    var modifiers: [Modifier]
    
    var attributes: [Attribute]
    
    var accessorBlocks: [AccessorBlock]
    
    var typeAnnotation: TypeAnnotation?
    
    var initializerClause: InitializerClause?
    
    var isConstant: Bool
    
    var isOptional: Bool {
        typeAnnotation?.isOptional == true
    }
    
    var isVariable: Bool {
        !isConstant
    }
    
    var isOfInferredType: Bool {
        typeAnnotation == nil
    }
    
    static func create(from node: VariableDeclSyntax) -> [VariableDeclSyntaxModel] {
        let identifiers = node.bindings.names
        let annotations = node.bindings.typeAnnotations
        let initializers = node.bindings.initializerClauses
        let accessors = node.bindings.accessorBlocks
        
        let modifiers = node.modifiers.modifiers
        let attributes = node.attributes.attributes
        
        var properties: [VariableDeclSyntaxModel] = []
        
        for (index, identifier) in identifiers.enumerated() {
            let annotation = index < annotations.count ? annotations[index] : annotations.last
            let initializer = index < initializers.count ? initializers[index] : nil
            
            let variable = VariableDeclSyntaxModel(
                name: identifier,
                text: node.trimmedDescription,
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
