//
//  DeclModifierListSyntax+ModifiersProviding.swift
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation
import SwiftSyntax

extension DeclModifierListSyntax: ModifiersProviding {
    public var modifiers: [Modifier] {
        compactMap {
            let detail = $0.detail?.trimmedDescription ?? ""
            return Modifier.from(value: $0.name.text + detail)
        }
    }
}
