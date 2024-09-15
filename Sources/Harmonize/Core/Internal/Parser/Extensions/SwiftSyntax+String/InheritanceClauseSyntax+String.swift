//
//  InheritanceClauseSyntax+String.swift
//
//
//  Created by Lucas Cavalcante on 9/15/24.
//

import Foundation
import SwiftSyntax

extension InheritanceClauseSyntax {
    func asString() -> [String] {
        inheritedTypes.compactMap {
            if let attributedType = $0.type.as(AttributedTypeSyntax.self) {
                return attributedType.baseType.trimmedDescription
            }
            
            return $0.type.trimmedDescription
        }
    }
}
