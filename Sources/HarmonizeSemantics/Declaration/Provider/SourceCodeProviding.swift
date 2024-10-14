//
//  SourceCodeProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

/// A protocol that provides access to the original source of a declaration.
public protocol SourceCodeProviding {
    /// The original location of this declaration.
    var sourceCodeLocation: SourceCodeLocation { get }
}
