//
//  Class+ClassDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 8/31/24.
//

import Foundation
import SwiftSyntax

extension Class {
    init(node: ClassDeclSyntax, file: SwiftFile) {
        self.name = node.name.text
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.inheritanceTypesNames = node.inheritanceClause?.asString() ?? []
        self.attributes = node.attributes.attributes
    }
}
