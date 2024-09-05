//
//  ParameterSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 9/1/24.
//

import Foundation
import SwiftSyntax

struct ParameterSyntaxModel: Parameter {
    var name: String
    
    var text: String
    
    var parent: Declaration? = nil
        
    var attributes: [Attribute]
    
    var modifiers: [Modifier]
    
    var typeAnnotation: TypeAnnotation?
    
    var label: String
    
    var initializerClause: InitializerClause?
    
    var isVariadic: Bool
    
    init(node: FunctionParameterSyntax, file: SwiftFile) {
        let firstName = node.firstName.text
        let secondName = node.secondName?.text
        
        let label = firstName == "_" ? "" : firstName
        
        let modifiers = node.modifiers.modifiers
        var attributes = node.attributes.attributes
        
        if let attributedTypeAttributes = node.type.as(AttributedTypeSyntax.self) {
            attributes.append(contentsOf: attributedTypeAttributes.attributes.attributes)
        }
        
        let variadic = node.ellipsis?.text ?? ""
        let type = TypeAnnotation(
            name: node.type.trimmedDescription + variadic,
            isOptional: node.type.is(OptionalTypeSyntax.self)
        )
        
        self.name = secondName ?? firstName
        self.text = node.trimmedDescription.replacingOccurrences(of: ",", with: "")
        self.modifiers = modifiers
        self.attributes = attributes
        self.label = label
        self.typeAnnotation = type
        self.isVariadic = node.ellipsis != nil
        self.initializerClause = node.defaultValue?.initializerClause
    }
}
