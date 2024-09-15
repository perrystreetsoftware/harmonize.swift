//
//  Enum+EnumDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

extension Enum {    
    init(node: EnumDeclSyntax, file: SwiftFile) {
        self.name = node.name.text
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.inheritanceTypesNames = node.inheritanceClause?.asString() ?? []
        self.attributes = node.attributes.attributes
        self.modifiers = node.modifiers.modifiers
    }
}
