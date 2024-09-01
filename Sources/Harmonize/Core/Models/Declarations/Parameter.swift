//
//  Parameter.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public protocol Parameter: Declaration,
                           AttributesProviding,
                           InitializerClauseProviding,
                           ModifiersProviding,
                           TypeAnnotationProviding {
    var label: String { get }
    
    /// Returns true if the parameter ends with ellipsis (variadic).
    var isVariadic: Bool { get }
}
