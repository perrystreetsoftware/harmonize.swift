//
//  Assertions.swift
//
//
//  Created by Lucas Cavalcante on 9/13/24.
//

import Foundation
import XCTest

public extension Array {
    func assertEmpty(
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard !self.isEmpty else { return }
        XCTFail(
            message ?? "collection has \(count) elements.",
            file: file,
            line: line
        )
    }
    
    func assertEmpty(
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Element: FileSourceProviding {
        guard !self.isEmpty else { return }
        let fallback = """
        Expected empty collection but got \(count) elements.
        At path: \(first?.filePath.absoluteString ?? "")
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
        condition: (Element) -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Element == SwiftFile {
        for element in self where !condition(element) {
            let fallback = """
            Expected true but got false on: \(element.fileName)
            at path: \(element.filePath.absoluteString)
            """
            
            XCTFail(
                message ?? fallback,
                file: file,
                line: line
            )
        }
    }
    
    func assertTrue(
        condition: (Element) -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Element: Declaration & FileSourceProviding {
        for element in self where !condition(element) {
            let name = (element as? NamedDeclaration)?.name ?? ""
            let fallback = """
            Expected true but got false on: \(type(of: element)) \(name)
            at path: \(element.filePath.absoluteString)
            """
            
            XCTFail(
                message ?? fallback,
                file: file,
                line: line
            )
        }
    }

    func assertFalse(
        condition: (Element) -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Element == SwiftFile {
        for element in self where condition(element) {
            XCTFail(
                message ?? "expected false got true on element: \(element)",
                file: file,
                line: line
            )
        }
    }
    
    func assertFalse(
        condition: (Element) -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Element: Declaration & FileSourceProviding {
        for element in self where condition(element) {
            let name = (element as? NamedDeclaration)?.name ?? ""
            let fallback = """
            Expected false but got true on: \(type(of: element)) \(name)
            at path: \(element.filePath.absoluteString)
            """
            
            XCTFail(
                message ?? fallback,
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
