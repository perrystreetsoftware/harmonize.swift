//
//  PatternBindingListSyntax+Providers.swift
//
//
//  Created by Lucas Cavalcante on 8/25/24.
//

import Foundation
import SwiftSyntax

extension PatternBindingListSyntax {
    var names: [String] {
        map { $0.pattern.trimmedDescription }
    }
    
    var accessorBlocks: [AccessorBlock] {
        compactMap { binding in binding.accessorBlock }.accessorBlocks
    }
    
    var initializerClauses: [InitializerClause] {
        compactMap { $0.initializer?.initializerClause }
    }
    
    var typeAnnotations: [TypeAnnotation] {
        compactMap { $0.typeAnnotation?.typeAnnotation }
    }
}
