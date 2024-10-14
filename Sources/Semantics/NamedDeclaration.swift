//
//  NamedDeclaration.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that represents a declaration with an associated name.
///
/// Types conforming to `NamedDeclaration` are expected to provide a `name` property that represents
/// the identifier or name of the declaration.
public protocol NamedDeclaration {
    /// The name of the declaration.
    ///
    /// This property holds the name associated with the declaration. For example, in the declaration
    /// `let file = "document.txt"`, `name` is `"file"`.
    var name: String { get }
}
