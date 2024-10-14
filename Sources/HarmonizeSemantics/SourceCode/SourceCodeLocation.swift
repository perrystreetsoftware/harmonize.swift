//
//  SourceCodeLocation.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

/// Represents the original file/location a given node belongs to.
/// This doesn't know about the exact location of a node.
public struct SourceCodeLocation {
    /// The file path to the source code file, if any.
    public let sourceFilePath: URL?
    
    /// The parsed original source file syntax tree.
    public let sourceFileTree: SourceFileSyntax
    
    public init(
        sourceFilePath: URL?,
        sourceFileTree: SourceFileSyntax
    ) {
        self.sourceFilePath = sourceFilePath
        self.sourceFileTree = sourceFileTree
    }
}
