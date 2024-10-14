//
//  InitializersProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides ``Initializer`` declarations found within a declaration.
public protocol InitializersProviding {
    /// A collection of ``Initializer`` instances found in this declaration.
    var initializers: [Initializer] { get }
}
