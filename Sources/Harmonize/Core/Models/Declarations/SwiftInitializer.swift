//
//  SwiftInitializer.swift
//
//
//  Created by Lucas Cavalcante on 8/28/24.
//

import Foundation

public struct SwiftInitializer: SwiftDeclaration, 
                                ModifiersProviding,
                                AttributesProviding,
                                ParametersProviding,
                                InitializersProviding,
                                FunctionsProviding,
                                PropertiesProviding {
    public var name: String
    
    public var text: String
    
    public var parent: SwiftDeclaration?
    
    public var children: [SwiftDeclaration]
    
    public var modifiers: [SwiftModifier]

    public var attributes: [SwiftAttribute]
    
    public var parameters: [SwiftParameter] {
        children.as(SwiftParameter.self)
    }
    
    public var initializers: [SwiftInitializer] {
        children.as(SwiftInitializer.self)
    }
    
    public var functions: [SwiftFunction] {
        children.as(SwiftFunction.self)
    }
    
    public var properties: [SwiftProperty] {
        children.as(SwiftProperty.self)
    }
    
    public var body: String?
}
