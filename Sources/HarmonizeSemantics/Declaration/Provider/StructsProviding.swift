//
//  StructsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides ``Struct`` declarations found within a declaration.
public protocol StructsProviding {
    /// A collection of ``Struct`` instances found in this declaration.
    var structs: [Struct] { get }
}
