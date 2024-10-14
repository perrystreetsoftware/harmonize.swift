//
//  Assertions.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics
import SwiftSyntax
import XCTest
import Testing

/// An experimental extension providing assertions API for `Array` where `Element` conforms to `SyntaxNodeProviding`.
/// These utilities enable behavior-driven assertions on the elements of the array, such as checking conditions, count, and emptiness.
public extension Array where Element == SwiftSourceCode {
    /// Asserts that the specified condition is true for all elements in the array.
    ///
    /// - parameters:
    ///   - message: An optional custom message to display on failure. If not provided, a default message will be used.
    ///   - showErrorAtSource: Flag to indicate if the assertion should show the error in the original source code.
    ///   - file: The file path to use in the assertion. Defaults to the calling file.
    ///   - line: The line number to use in the assertion. Defaults to the calling line.
    ///   - condition: A closure that takes an element and returns a `Bool` indicating if the condition is met.
    /// - warning: This method will try report all issues in the original source code location when available.
    func assertTrue(
        message: String? = nil,
        showErrorAtSource: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line,
        condition: (Element) -> Bool
    ) {
        var issues = [(String, XCTIssue)]()
    
        for element in self where !condition(element) {
            let name = element.fileName ?? ""
            let defaultMessage = """
            Expected true but got false on source: \(name)
            """
            
            if let issue = element.issue(with: message ?? defaultMessage) {
                issues.append((name, issue))
            }
        }
        
        guard !issues.isEmpty else { return }
        
        fail(
            with: issues,
            message: message,
            printAllIssues: showErrorAtSource,
            originallyAt: file,
            originallyIn: line
        )
    }
    
    /// Asserts that the specified condition is false for all elements in the array while also reporting found issues in the
    /// original source code location. This is an experimental feature and may not function properly.
    ///
    /// - parameters:
    ///   - message: An optional custom message to display on failure. If not provided, a default message will be used.
    ///   - showErrorAtSource: Flag to indicate if the assertion should show the error in the original source code.
    ///   - file: The file path to use in the assertion. Defaults to the calling file.
    ///   - line: The line number to use in the assertion. Defaults to the calling line.
    ///   - condition: A closure that takes an element and returns a `Bool` indicating if the condition is met.
    /// - warning: This method will try report all issues in the original source code location when available.
    func assertFalse(
        message: String? = nil,
        showErrorAtSource: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line,
        condition: (Element) -> Bool
    ) {
        var issues = [(String, XCTIssue)]()
    
        for element in self where condition(element) {
            let name = (element as? NamedDeclaration)?.name ?? ""
            let defaultMessage = """
            Expected false but got true on: \(type(of: element)) \(name)
            """
            
            if let issue = element.issue(with: message ?? defaultMessage) {
                issues.append((name, issue))
            }
        }
        
        guard !issues.isEmpty else { return }
        
        fail(
            with: issues,
            message: message,
            printAllIssues: showErrorAtSource,
            originallyAt: file,
            originallyIn: line
        )
    }
    
    /// Asserts that the array is empty.
    ///
    /// - parameters:
    ///   - file: The file path to use in the assertion. Defaults to the calling file.
    ///   - line: The line number to use in the assertion. Defaults to the calling line.
    /// - warning: This method is experimental and subject to change.
    func assertEmpty(
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard !isEmpty else { return }
        XCTFail(
            "Assertion failed expecting empty collection, got 0 elements instead.",
            file: file,
            line: line
        )
    }
    
    /// Asserts that the array is not empty.
    ///
    /// - parameters:
    ///   - file: The file path to use in the assertion. Defaults to the calling file.
    ///   - line: The line number to use in the assertion. Defaults to the calling line.
    /// - warning: This method is experimental and subject to change.
    func assertNotEmpty(
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard isEmpty else { return }
        XCTFail(
            "Assertion failed expecting non empty collection, got empty instead.",
            file: file,
            line: line
        )
    }
    
    /// Asserts that the array has the specified number of elements.
    ///
    /// - parameters:
    ///   - count: The expected number of elements in the array.
    ///   - file: The file path to use in the assertion. Defaults to the calling file.
    ///   - line: The line number to use in the assertion. Defaults to the calling line.
    /// - warning: This method is experimental and subject to change.
    func assertCount(
        count: Int,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard self.count != count else { return }
        XCTFail(
            "Assertion failed expecting count \(count), got \(self.count).",
            file: file,
            line: line
        )
    }
}
