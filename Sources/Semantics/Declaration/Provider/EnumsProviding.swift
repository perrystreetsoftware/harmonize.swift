//
//  EnumsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides ``Enum`` declarations found within a declaration.
public protocol EnumsProviding {
    /// A collection of ``Enum`` instances found in this declaration.
    var enums: [Enum] { get }
}
