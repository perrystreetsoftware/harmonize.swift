//
//  TypeAnnotationSyntax+TypeAnnotationProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/1/24.
//

import Foundation
import SwiftSyntax

extension TypeAnnotationSyntax: TypeAnnotationProviding {
    public var typeAnnotation: TypeAnnotation? {
        type.typeAnnotation
    }
}

extension TypeSyntax {
    public var typeAnnotation: TypeAnnotation {
        TypeAnnotation(
            name: trimmedDescription,
            isOptional: self.is(OptionalTypeSyntax.self)
        )
    }
}
