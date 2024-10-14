//
//  SyntaxNodeProviding+XCTIssue.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import HarmonizeSemantics
import SwiftSyntax
import XCTest

internal extension SyntaxNodeProviding {
    func issue(with message: String) -> XCTIssue? {
        guard let sourceCodeProvider = self as? SourceCodeProviding else { return nil }
        
        guard let sourcePath = sourceCodeProvider.sourceCodeLocation.sourceFilePath
        else { return nil }
        
        let locationCoverter = SourceLocationConverter(
            fileName: sourcePath.relativePath,
            tree: sourceCodeProvider.sourceCodeLocation.sourceFileTree
        )
        
        let lineNumber = self.node.startLocation(converter: locationCoverter).line
        
        let sourceCodeLocation = XCTSourceCodeLocation(
            fileURL: sourcePath,
            lineNumber: lineNumber
        )
        
        return XCTIssue(
            type: .assertionFailure,
            compactDescription: message,
            detailedDescription: message,
            sourceCodeContext: .init(location: sourceCodeLocation)
        )
    }
}
