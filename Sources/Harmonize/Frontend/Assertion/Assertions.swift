//
//  Assertions.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics
import XCTest

public extension Array {
    func assertEmpty(
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard !self.isEmpty else { return }
        let fallback = """
        Expected empty collection but got \(count) elements.
        """
        
        XCTFail(
            message ?? fallback,
            file: file,
            line: line
        )
    }

    func assertNotEmpty(
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard self.isEmpty else { return }
        let fallback = """
        Expected non empty collection but got 0 elements.
        """
        
        XCTFail(
            message ?? fallback,
            file: file,
            line: line
        )
    }

    func assertTrue(
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line,
        condition: (Element) -> Bool
    ) where Element == SwiftSourceCode {
        for element in self where !condition(element) {
            let fallback = """
            Expected true but got false on: \(element.fileName ?? "")
            """
            
            XCTFail(
                message ?? fallback,
                file: file,
                line: line
            )
        }
    }
    
    func assertTrue(
        message: ((Element) -> String)? = nil,
        file: StaticString = #filePath,
        line: UInt = #line,
        condition: (Element) -> Bool
    ) where Element: Declaration {
        for element in self where !condition(element) {
            let name = (element as? NamedDeclaration)?.name ?? ""
            let fallback = """
            Expected true but got false on: \(type(of: element)) \(name)
            at path: 
            """
            
            XCTFail(
                message?(element) ?? fallback,
                file: file,
                line: line
            )
        }
    }

    func assertFalse(
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line,
        condition: (Element) -> Bool
    ) where Element == SwiftSourceCode {
        for element in self where condition(element) {
            XCTFail(
                message ?? "expected false got true on element: \(element)",
                file: file,
                line: line
            )
        }
    }
    
    func assertFalse(
        message: ((Element) -> String)? = nil,
        file: StaticString = #filePath,
        line: UInt = #line,
        condition: (Element) -> Bool
    ) where Element: Declaration {
        for element in self where condition(element) {
            let name = (element as? NamedDeclaration)?.name ?? ""
            let fallback = """
            Expected false but got true on: \(type(of: element)) \(name)
            at path: 
            """
            
            XCTFail(
                message?(element) ?? fallback,
                file: file,
                line: line
            )
        }
    }
    
    package func assertCount(
        count: Int,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard self.count != count else { return }
        XCTFail(
            message ?? "expected count \(count), got \(self.count)",
            file: file,
            line: line
        )
    }
}
