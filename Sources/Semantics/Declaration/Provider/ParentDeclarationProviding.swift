//
//  ParentDeclarationProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides access to the parent declaration of a nested or child declaration.
public protocol ParentDeclarationProviding {
    /// The parent declaration for this declaration. This can be `nil` if there is no parent.
    var parent: Declaration? { get }
}
