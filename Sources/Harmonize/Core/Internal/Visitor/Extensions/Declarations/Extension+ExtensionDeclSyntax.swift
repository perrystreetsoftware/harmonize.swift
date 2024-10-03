//
//  Extension+ExtensionDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

extension Extension {
    init(node: ExtensionDeclSyntax, file: SwiftFile) {
        self.extendedTypeName = node.extendedType.trimmedDescription
        self.genericWhereClause = node.genericWhereClause?.trimmedDescription
        self.typeAnnotation = node.extendedType.typeAnnotation
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.inheritanceTypesNames = node.inheritanceClause?.asString() ?? []
        self.attributes = node.attributes.attributes
        self.modifiers = node.modifiers.modifiers
    }
}
