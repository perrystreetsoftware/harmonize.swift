//
//  ClassesProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides ``Class`` declarations found within a declaration.
public protocol ClassesProviding {
    /// A collection of ``Class`` instances found in this declaration.
    var classes: [Class] { get }
}
