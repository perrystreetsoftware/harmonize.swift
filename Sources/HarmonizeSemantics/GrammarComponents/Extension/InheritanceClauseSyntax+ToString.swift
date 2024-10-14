//
//  InheritanceClauseSyntax+ToString.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

extension InheritanceClauseSyntax {
    func toString() -> [String] {
        inheritedTypes.compactMap {
            if let attributedType = $0.type.as(AttributedTypeSyntax.self) {
                return attributedType.baseType.trimmedDescription
            }
            
            return $0.type.trimmedDescription
        }
    }
}
