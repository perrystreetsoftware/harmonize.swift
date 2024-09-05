//
//  EnumCaseDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

struct EnumCaseDeclSyntaxModel: EnumCase {
    var name: String
    
    var text: String
    
    var parent: Declaration?
            
    var attributes: [Attribute]
    
    var modifiers: [Modifier]
    
    var initializerClause: InitializerClause?
    
    var parameters: [EnumCaseParameter]
    
    static func create(from node: EnumCaseDeclSyntax) -> [EnumCase] {
        let attributes = node.attributes.attributes
        let modifiers = node.modifiers.modifiers
        
        return node.elements.map { element in
            EnumCaseDeclSyntaxModel(
                name: element.name.text,
                text: element.trimmedDescription,
                attributes: attributes,
                modifiers: modifiers,
                initializerClause: element.rawValue?.initializerClause,
                parameters: element.parameterClause?.parameters.map {
                    let label = [$0.firstName?.text, $0.secondName?.text]
                        .compactMap { $0 }
                        .joined(separator: " ")
                    
                    return EnumCaseParameter(
                        label: label.isEmpty ? nil : label,
                        typeAnnotation: $0.type.typeAnnotation
                    )
                } ?? []
            )
        }
    }
}
