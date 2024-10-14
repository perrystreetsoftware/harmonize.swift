//
//  Fail.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import XCTest

internal func fail(
    with issues: [(String, XCTIssue)],
    message: String? = nil,
    printAllIssues: Bool = true,
    originallyAt file: StaticString = #filePath,
    originallyIn line: UInt = #line
) {
    let issuesLocation = issues.compactMap {
        if let location = $1.sourceCodeContext.location {
            return ($0, location)
        }
        
        return nil
    }
    
    let invalidDeclarations = issuesLocation
        .map { "\($1.fileURL):\($1.lineNumber) (\($0))" }
        .joined(separator: "\n\n")
    
    let detailedMessage = """
    Assertion expecting true as violated \(issues.count) times.
    \(message ?? "")
    Invalid declarations:
    \(invalidDeclarations))
    """
    
    XCTFail(detailedMessage, file: file, line: line)
    
    guard printAllIssues else { return }
    
    issues.forEach { name, issue in
        if let location = issue.sourceCodeContext.location {
            location.fileURL.relativePath.withStaticString {
                XCTFail(
                    issue.compactDescription,
                    file: $0,
                    line: UInt(location.lineNumber)
                )
            }
        }
    }
}
