//
//  DeclarationsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that provides declarations found within a declaration.
public protocol DeclarationsProviding {
    /// A collection of ``Declaration`` objects representing the declarations
    /// contained in this declaration.
    ///
    /// The `declarations` property provides access to the collection of declarations
    /// (such as classes, functions, etc.) that have been found in this declaration.
    var declarations: [Declaration] { get }
}
