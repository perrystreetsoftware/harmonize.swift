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

    func assertNotEmpty(
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard self.isEmpty else { return }
        XCTFail(
            message ?? "collection is empty.",
            file: file,
            line: line
        )
    }

    func assertTrue(
        condition: (Element) -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for element in self where condition(element) {
            XCTFail(
                message ?? "expected true got false on element: \(element)",
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
    ) {
        for element in self where !condition(element) {
            XCTFail(
                message ?? "expected false got true on element: \(element)",
                file: file,
                line: line
            )
        }
    }
}
