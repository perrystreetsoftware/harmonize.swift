//
//  CodeBlockItemListSyntax+String.swift
//
//
//  Created by Lucas Cavalcante on 9/1/24.
//

import Foundation
import SwiftSyntax

extension CodeBlockItemListSyntax {
    func asString() -> String {
        compactMap {
            return if let value = $0.item.as(StringLiteralExprSyntax.self) {
                value.representedLiteralValue
            } else {
                $0.trimmedDescription
            }
        }.joined(separator: "\n")
    }
}
