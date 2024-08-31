//
//  SwiftFunction.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public struct SwiftFunction: SwiftDeclaration,
                             BodyProviding,
                             ParametersProviding,
                             ModifiersProviding,
                             FunctionsProviding {
    public var name: String
    
    public var text: String
    
    public var parent: SwiftDeclaration?
    
    public var children: [SwiftDeclaration]
    
    public var modifiers: [SwiftModifier]
    
    public var functions: [SwiftFunction] {
        children.as(SwiftFunction.self)
    }
    
    public var parameters: [SwiftParameter] {
        children.as(SwiftParameter.self)
    }
    
    public let returnClause: SwiftReturnClause
    
    public let genericClause: String?
    
    public let whereClause: String?
    
    public let body: String?
}
