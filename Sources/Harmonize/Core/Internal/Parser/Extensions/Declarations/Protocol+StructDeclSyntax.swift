//
//  ProtocolDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 9/1/24.
//

import Foundation
import SwiftSyntax

extension ProtocolDeclaration {
    init(node: ProtocolDeclSyntax, file: SwiftFile) {
        self.name = node.name.text
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.inheritanceTypesNames = node.inheritanceClause?.asString() ?? []
        self.attributes = node.attributes.attributes
    }
}
