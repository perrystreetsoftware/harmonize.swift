//
//  ExtensionDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

struct ExtensionDeclSyntaxModel: Extension {
    var extendedTypeName: String
    
    var genericWhereClause: String?
    
    var text: String
    
    var children: [Declaration] = []
    
    var swiftFile: SwiftFile
    
    var inheritanceTypesNames: [String]
    
    var attributes: [Attribute]
    
    var modifiers: [Modifier]
    
    var properties: [Property] {
        children.as(Property.self)
    }
    
    var functions: [Function] {
        children.as(Function.self)
    }
    
    var initializers: [Initializer] {
        children.as(Initializer.self)
    }
    
    init(node: ExtensionDeclSyntax, file: SwiftFile) {
        self.extendedTypeName = node.extendedType.trimmedDescription
        self.genericWhereClause = node.genericWhereClause?.trimmedDescription
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.inheritanceTypesNames = node.inheritanceClause?.typesAsString() ?? []
        self.attributes = node.attributes.attributes
        self.modifiers = node.modifiers.modifiers
    }
}
