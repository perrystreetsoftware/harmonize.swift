//
//  SwiftParameter.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public struct SwiftParameter: SwiftDeclaration, AttributesProviding {
    public var name: String
    
    public var text: String
    
    public var parent: SwiftDeclaration?
    
    public var children: [SwiftDeclaration]
    
    public var modifiers: [SwiftModifier]
    
    public var attributes: [SwiftAttribute]
    
    public let label: String
    
    /// The underlying type name of this property, such as String, Int, Bool, Array etc.
    public let typeAnnotation: String
    
    /// The default value of the parameter.
    public let defaultValue: String?
    
    /// Returns true if the parameter is of an optional type.
    public var isOptional: Bool
    
    /// Returns true if the parameter ends with ellipsis (variadic).
    public var isVariadic: Bool
}
