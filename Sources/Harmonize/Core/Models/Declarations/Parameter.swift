//
//  Parameter.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public struct Parameter: Declaration,
                         NamedDeclaration,
                         ParentDeclarationProviding,
                         AttributesProviding,
                         InitializerClauseProviding,
                         ModifiersProviding,
                         TypeAnnotationProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration? = nil
        
    public var attributes: [Attribute]
    
    public var modifiers: [Modifier]
    
    public var typeAnnotation: TypeAnnotation?
    
    public var label: String
    
    public var initializerClause: InitializerClause?
        
    /// Returns true if the parameter ends with ellipsis (variadic).
    public var isVariadic: Bool
}
