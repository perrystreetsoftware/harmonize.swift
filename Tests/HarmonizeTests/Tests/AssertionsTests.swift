//
//  Assertions.swift
//
//
//  Created by Lucas Cavalcante on 9/13/24.
//

import Foundation
import XCTest
import Harmonize

final class AssertionsTests: XCTestCase {
    func testAssertEmpty() throws {
        Harmonize.productionCode().on("Tests")
            .files()
            .assertEmpty()
    }
    
    func testAssertNotEmpty() throws {
        Harmonize.testCode().on("Tests")
            .files()
            .assertNotEmpty()
    }
    
    func testAssertTrue() throws {
        Harmonize.testCode().on("Tests")
            .files()
            .assertTrue { $0.fileName.hasSuffix("Tests") }
    }
    
    func testAssertFalse() throws {
        Harmonize.testCode().on("Tests")
            .files()
            .assertFalse { !$0.fileName.hasSuffix("Tests") }
    }
}
