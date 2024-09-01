//
//  InitializerClauseSyntax+InitializerClauseProviding.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation
import SwiftSyntax

extension InitializerClauseSyntax: InitializerClauseProviding {
    public var initializerClause: InitializerClause? {
        if let initializer = self.as(InitializerClauseSyntax.self) {
            let valueString = if let value = initializer.value.as(StringLiteralExprSyntax.self) {
                value.representedLiteralValue
            } else {
                initializer.value.trimmedDescription
            }
            
            return InitializerClause(value: valueString ?? "")
        }
        
        return nil
    }
}
