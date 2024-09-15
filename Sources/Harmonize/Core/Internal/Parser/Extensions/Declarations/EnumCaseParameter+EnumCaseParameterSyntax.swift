//
//  EnumCaseParameter+EnumCaseParameterSyntax.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

extension EnumCaseParameter {    
    init(node: EnumCaseParameterSyntax) {
        let label = [node.firstName?.text, node.secondName?.text]
            .compactMap { $0 }
            .joined(separator: " ")
        
        self.label = label.isEmpty ? nil : label
        self.typeAnnotation = node.type.typeAnnotation
        self.text = node.trimmedDescription
    }
}
