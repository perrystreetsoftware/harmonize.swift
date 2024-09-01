//
//  FunctionDeclSyntaxModel.swift
//  
//
//  Created by Lucas Cavalcante on 9/1/24.
//

import Foundation
import SwiftSyntax

struct FunctionDeclSyntaxModel: Function {
    var name: String
    
    var text: String
    
    var parent: Declaration? = nil
    
    var children: [Declaration] = []
    
    var swiftFile: SwiftFile
    
    var modifiers: [Modifier]
    
    var functions: [Function] {
        children.as(Function.self)
    }
    
    var parameters: [Parameter] {
        children.as(Parameter.self)
    }
    
    let returnClause: ReturnClause
    
    let genericClause: String?
    
    let whereClause: String?
    
    let body: String?
    
    init(node: FunctionDeclSyntax, file: SwiftFile) {
        self.name = node.name.text
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.modifiers = node.modifiers.modifiers
        self.genericClause = node.genericParameterClause?.trimmedDescription
        self.whereClause = node.genericWhereClause?.trimmedDescription
        self.body = node.body?.statements.asString()
        self.returnClause = ReturnClause.from(node.signature.returnClause?.type.trimmedDescription)
    }
}
