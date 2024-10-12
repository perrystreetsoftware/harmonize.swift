//
//  Assertions.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import XCTest
import Harmonize

final class AssertionsTests: XCTestCase {
    let productionCode = Harmonize.productionCode().on("SampleApp")
    let testCode = Harmonize.testCode().on("SampleApp")
    
    func testAssertEmpty() throws {
        productionCode.sources().filter { $0.fileName?.contains("Tests") == true }.assertEmpty()
    }
    
    func testAssertNotEmpty() throws {
       testCode.sources().assertNotEmpty()
    }
    
    func testAssertTrue() throws {
        testCode.sources().assertTrue { _ in
            true
        }
    }
    
    func testAssertFalse() throws {
        testCode.sources().assertFalse { _ in
            false
        }
    }
    
    func testAssertCount() throws {
        productionCode.sources().assertCount(count: 2)
    }
}
