//
//  EnumCase+EnumCaseDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

extension EnumCase {
    static func create(from node: EnumCaseDeclSyntax) -> [EnumCase] {
        let attributes = node.attributes.attributes
        let modifiers = node.modifiers.modifiers
        
        return node.elements.map { element in
            EnumCase(
                name: element.name.text,
                text: element.trimmedDescription,
                attributes: attributes,
                modifiers: modifiers,
                initializerClause: element.rawValue?.initializerClause,
                parameters: element.parameterClause?.parameters.map {
                    EnumCaseParameter(node: $0)
                } ?? []
            )
        }
    }
}
