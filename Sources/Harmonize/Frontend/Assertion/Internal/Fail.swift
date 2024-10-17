//
//  Fail.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import XCTest

internal func fail(
    issues: [(String, XCTIssue)],
    testMessage: String,
    showIssueAtSource: Bool = true,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let issuesLocation = issues.compactMap {
        if let location = $1.sourceCodeContext.location {
            return ($0, location)
        }
        
        return nil
    }
    
    let violations = issuesLocation
        .map { "\($1.fileURL):\($1.lineNumber) (\($0))" }
        .joined(separator: "\n\n")
    
    let detailedTestMessage = """
    \(testMessage)

    Found \(issues.count) violations:
    
    \(violations))
    """
    
    XCTFail(detailedTestMessage, file: file, line: line)
    
    guard showIssueAtSource else { return }
    
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
