//
//  Function.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public struct Function: Declaration,
                        BodyProviding,
                        ParametersProviding,
                        ModifiersProviding,
                        FunctionsProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration?
    
    public var children: [Declaration]
    
    public var modifiers: [Modifier]
    
    public var functions: [Function] {
        children.as(Function.self)
    }
    
    public var parameters: [Parameter] {
        children.as(Parameter.self)
    }
    
    public let returnClause: ReturnClause
    
    public let genericClause: String?
    
    public let whereClause: String?
    
    public let body: String?
}
