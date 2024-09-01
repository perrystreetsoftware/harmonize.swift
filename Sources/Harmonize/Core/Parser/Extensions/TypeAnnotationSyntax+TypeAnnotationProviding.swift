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
        TypeAnnotation(
            name: type.trimmedDescription,
            isOptional: type.is(OptionalTypeSyntax.self)
        )
    }
}
