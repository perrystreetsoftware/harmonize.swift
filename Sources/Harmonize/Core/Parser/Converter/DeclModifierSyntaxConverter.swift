//
//  DeclModifierSyntaxConverter.swift
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation
import SwiftSyntax

class DeclModifierSyntaxConverter {
    func convert(_ node: DeclModifierListSyntax) -> [Modifier] {
        node.compactMap {
            let detail = $0.detail?.trimmedDescription ?? ""
            return Modifier.from(value: $0.name.text + detail)
        }
    }
}
