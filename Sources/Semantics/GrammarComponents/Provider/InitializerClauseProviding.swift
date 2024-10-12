//
//  InitializerClauseProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation

/// A protocol that provides access to an initializer clause in a declaration.
public protocol InitializerClauseProviding {
    /// The initializer clause for this declaration, if present.
    var initializerClause: InitializerClause? { get }
}
