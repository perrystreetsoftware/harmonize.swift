//
//  TypeAnnotationProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that represents declarations capable of providing a type annotation.
public protocol TypeProviding {
    /// The type annotation of the declaration, if any.
    ///
    /// This property returns an optional `TypeAnnotation`, representing the type of the declaration.
    /// For example, in the declaration `let number: Int`, the `typeAnnotation` is`Int`.
    /// If the declaration doesn't specify a type, this property returns `nil`.
    var typeAnnotation: TypeAnnotation? { get }
}
