//
//  ParametersProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

/// A protocol that provides ``Parameter`` declarations found within a declaration.
public protocol ParametersProviding {
    /// A collection of ``Parameter`` instances found in this declaration.
    var parameters: [Parameter] { get }
}
