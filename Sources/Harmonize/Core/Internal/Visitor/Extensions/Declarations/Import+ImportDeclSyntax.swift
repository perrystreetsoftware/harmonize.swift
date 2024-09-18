//
//  Import+ImportDeclSyntax.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

extension Import {
    init(_ node: ImportDeclSyntax, _ file: SwiftFile) {
        self.name = node.path.map { $0.name.text }.joined(separator: ".")
        self.text = node.trimmedDescription
        self.kind = ImportKind(rawValue: node.importKindSpecifier?.text ?? "") ?? .none
        self.attributes = node.attributes.attributes
        self.swiftFile = file
    }
}
