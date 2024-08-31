//
//  Parameter.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public struct Parameter: Declaration, AttributesProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration?
    
    public var children: [Declaration]
    
    public var modifiers: [Modifier]
    
    public var attributes: [Attribute]
    
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
