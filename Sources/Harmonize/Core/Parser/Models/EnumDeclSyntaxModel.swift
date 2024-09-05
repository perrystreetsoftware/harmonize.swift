//
//  EnumDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

struct EnumDeclSyntaxModel: Enum {
    var name: String
    
    var text: String
    
    var parent: Declaration? = nil
    
    var children: [Declaration] = []
    
    var swiftFile: SwiftFile
    
    var inheritanceTypesNames: [String]
    
    var attributes: [Attribute]
    
    var modifiers: [Modifier]
    
    var cases: [EnumCase] {
        children.as(EnumCase.self)
    }
    
    var properties: [Property] {
        children.as(Property.self)
    }
    
    var functions: [Function] {
        children.as(Function.self)
    }

    var initializers: [Initializer] {
        children.as(Initializer.self)
    }
    
    init(node: EnumDeclSyntax, file: SwiftFile) {
        self.name = node.name.text
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.inheritanceTypesNames = node.inheritanceClause?.typesAsString() ?? []
        self.attributes = node.attributes.attributes
        self.modifiers = node.modifiers.modifiers
    }
}
