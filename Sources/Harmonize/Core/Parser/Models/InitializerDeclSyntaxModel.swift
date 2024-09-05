//
//  InitializerDeclSyntaxModel.swift
//
//
//  Created by Lucas Cavalcante on 8/31/24.
//

import Foundation
import SwiftSyntax

struct InitializerDeclSyntaxModel: Initializer {
    var text: String
    
    var parent: Declaration? = nil
    
    var children: [Declaration] = []
    
    var swiftFile: SwiftFile
        
    var body: String?
    
    var attributes: [Attribute]
    
    var modifiers: [Modifier]
    
    var parameters: [Parameter] {
        children.as(Parameter.self)
    }
    
    var properties: [Property] {
        children.as(Property.self)
    }
    
    var functions: [Function] {
        children.as(Function.self)
    }

    var initializers: [Initializer] {
        children.as(Initializer.self)
    }
    
    init(node: InitializerDeclSyntax, file: SwiftFile) {
        self.text = node.trimmedDescription
        self.swiftFile = file
        self.attributes = node.attributes.attributes
        self.modifiers = node.modifiers.modifiers
        self.body = node.body?.statements.asString()
    }
}
