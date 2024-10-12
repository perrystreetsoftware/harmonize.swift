//
//  FunctionsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides ``Function`` declarations found within a declaration.
public protocol FunctionsProviding {
    /// A collection of ``Function`` instances found in this declaration.
    var functions: [Function] { get }
}
