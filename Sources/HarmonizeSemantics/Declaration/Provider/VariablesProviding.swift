//
//  VariablesProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides ``Variable`` declarations found within a declaration.
public protocol VariablesProviding {
    /// A collection of ``Variable`` instances found in this declaration.
    var variables: [Variable] { get }
}
