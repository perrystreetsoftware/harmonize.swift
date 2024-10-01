//
//  Function+FunctionDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 9/1/24.
//

import Foundation
import SwiftSyntax

extension Function {
    init(node: FunctionDeclSyntax, file: SwiftFile) {
        self.name = node.name.text
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.modifiers = node.modifiers.modifiers
        self.genericClause = node.genericParameterClause?.trimmedDescription
        self.whereClause = node.genericWhereClause?.trimmedDescription
        self.body = node.body?.statements.asString()
        self.returnClause = ReturnClause.from(node.signature.returnClause?.type.trimmedDescription)
        self.functionCalls = node.body?.statements.compactMap {
            $0.item.as(FunctionCallExprSyntax.self)
        }.map { $0.calledExpression.trimmedDescription } ?? []
    }
}
