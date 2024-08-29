//
//  InitializerClauseSyntaxConverter.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation
import SwiftSyntax

class InitializerClauseSyntaxConverter {
    func convert(_ node: InitializerClauseSyntax?) -> SwiftInitializerClause? {
        guard let initializer = node else { return nil }
        
        if let initializer = initializer.as(InitializerClauseSyntax.self) {
            let valueString = if let value = initializer.value.as(StringLiteralExprSyntax.self) {
                value.representedLiteralValue
            } else {
                initializer.value.trimmedDescription
            }
            
            return SwiftInitializerClause(value: valueString ?? "")
        }
        
        return nil
    }
}
