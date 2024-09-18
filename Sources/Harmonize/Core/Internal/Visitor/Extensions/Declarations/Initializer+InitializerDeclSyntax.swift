//
//  Initializer+InitializerDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 8/31/24.
//

import Foundation
import SwiftSyntax

extension Initializer {
    init(node: InitializerDeclSyntax, file: SwiftFile) {
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.attributes = node.attributes.attributes
        self.modifiers = node.modifiers.modifiers
        self.body = node.body?.statements.asString()
    }
}
