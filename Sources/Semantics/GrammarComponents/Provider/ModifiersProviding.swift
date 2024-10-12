//
//  ModifiersProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides access to the modifiers of a declaration.
public protocol ModifiersProviding {
    /// An array of all modifiers applied to the declaration, such as `public`, `private`, `fileprivate`, etc.
    var modifiers: [Modifier] { get }
}

// MARK: - Checkers

public extension ModifiersProviding {
    /// Checks if the declaration has the specified modifiers.
    func hasModifier(_ modifier: Modifier) -> Bool {
        modifiers.contains(modifier)
    }
    
    /// Returns the count of modifiers applied to the declaration.
    func withModifiersCount() -> Int {
        modifiers.count
    }
}
