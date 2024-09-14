//
//  EnumCaseParameterSyntax+EnumCaseParameter.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import SwiftSyntax

extension EnumCaseParameterSyntax: EnumCaseParameter {
    public var label: String? {
        let label = [firstName?.text, secondName?.text]
            .compactMap { $0 }
            .joined(separator: " ")

        return label.isEmpty ? nil : label
    }
    
    public var typeAnnotation: TypeAnnotation? {
        type.typeAnnotation
    }
    
    public var text: String {
        trimmedDescription
    }
}
