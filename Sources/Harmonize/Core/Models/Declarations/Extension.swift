//
//  Extension.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public protocol Extension: Declaration,
                           ChildrenDeclarationProviding,
                           FileSourceProviding,
                           InheritanceProviding,
                           PropertiesProviding,
                           ModifiersProviding,
                           AttributesProviding,
                           FunctionsProviding,
                           InitializersProviding {
    /// The extension's target type name.
    var extendedTypeName: String { get }
    
    var genericWhereClause: String? { get }
}
