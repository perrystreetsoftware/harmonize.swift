//
//  TypeAnnotation.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/12/24.
//

import Semantics

public extension TypeAnnotation {
    /// Compares a `TypeAnnotation` instance with a given type to check for equality.
    ///
    /// This operator overload allows for comparing a `TypeAnnotation` directly with a type.
    /// It checks if the annotation string representation of the `TypeAnnotation` is equal
    /// to the string representation of the type.
    ///
    /// - parameters:
    ///   - lhs: The `TypeAnnotation` instance on the left side of the equality operator.
    ///   - rhs: The type to compare against, which can be any type `T`.
    /// - returns: A Boolean value indicating whether the `TypeAnnotation`'s annotation
    ///   matches the string representation of the type.
    static func == <T>(lhs: TypeAnnotation, rhs: T.Type) -> Bool {
        lhs.annotation == String(describing: rhs.self)
    }
}
