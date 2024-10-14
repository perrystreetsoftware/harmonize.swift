//
//  CodeBlockItemListSyntax+ToString.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

extension CodeBlockItemListSyntax {
    func toString() -> String {
        compactMap {
            return if let value = $0.item.as(StringLiteralExprSyntax.self) {
                value.representedLiteralValue
            } else {
                $0.trimmedDescription
            }
        }.joined(separator: "\n")
    }
}
