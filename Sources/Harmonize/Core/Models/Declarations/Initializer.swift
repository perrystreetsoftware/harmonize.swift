//
//  Initializer.swift
//
//
//  Created by Lucas Cavalcante on 8/28/24.
//

import Foundation

public struct Initializer: Declaration,
                           BodyProviding,
                           ModifiersProviding,
                           AttributesProviding,
                           ParametersProviding,
                           InitializersProviding,
                           FunctionsProviding,
                           PropertiesProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration?
    
    public var children: [Declaration]
    
    public var modifiers: [Modifier]

    public var attributes: [Attribute]
    
    public var parameters: [Parameter] {
        children.as(Parameter.self)
    }
    
    public var initializers: [Initializer] {
        children.as(Initializer.self)
    }
    
    public var functions: [Function] {
        children.as(Function.self)
    }
    
    public var properties: [Property] {
        children.as(Property.self)
    }
    
    public let body: String?
}
