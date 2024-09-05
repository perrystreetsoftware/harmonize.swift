//
//  ImportDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

struct ImportDeclSyntaxModel: Import {
    var text: String
    
    var name: String
    
    var kind: ImportKind
    
    var swiftFile: SwiftFile
    
    var attributes: [Attribute]
    
    init(_ node: ImportDeclSyntax, _ file: SwiftFile) {
        self.name = node.path.map { $0.name.text }.joined(separator: ".")
        self.text = node.trimmedDescription
        self.kind = ImportKind(rawValue: node.importKindSpecifier?.text ?? "") ?? .none
        self.attributes = node.attributes.attributes
        self.swiftFile = file
    }
}
