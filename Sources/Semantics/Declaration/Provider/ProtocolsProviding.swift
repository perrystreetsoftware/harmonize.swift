//
//  ProtocolsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides ``Protocol`` declarations found within a declaration.
public protocol ProtocolsProviding {
    /// A collection of ``Protocol`` instances found in this declaration.
    var protocols: [ProtocolDeclaration] { get }
}
