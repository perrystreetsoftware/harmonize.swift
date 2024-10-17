//
//  Assertions.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import XCTest
import Harmonize
import HarmonizeSemantics

final class AssertionsTests: XCTestCase {
    let productionCode = Harmonize.productionCode().on("SampleApp")
    let testCode = Harmonize.testCode().on("SampleApp")
    
    func testAssertEmpty() throws {
        [Class]().assertEmpty()
    }
    
    func testAssertNotEmpty() throws {
        testCode.classes().assertNotEmpty()
    }
    
    func testAssertTrue() throws {
        testCode.classes().assertTrue { _ in
            true
        }
    }
    
    func testAssertFalse() throws {
        testCode.classes().assertFalse { _ in
            false
        }
    }
    
    func testAssertCount() throws {
        productionCode.classes().assertCount(count: 3)
    }
}
