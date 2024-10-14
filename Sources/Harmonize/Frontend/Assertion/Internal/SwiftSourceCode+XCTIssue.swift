//
//  SwiftSourceCode+XCTIssue.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import XCTest

internal extension SwiftSourceCode {
    func issue(with message: String) -> XCTIssue? {
        guard let sourcePath = filePath else { return nil }
        
        let sourceCodeLocation = XCTSourceCodeLocation(
            fileURL: sourcePath,
            lineNumber: 1
        )
        
        return XCTIssue(
            type: .assertionFailure,
            compactDescription: message,
            detailedDescription: message,
            sourceCodeContext: .init(location: sourceCodeLocation)
        )
    }
}
