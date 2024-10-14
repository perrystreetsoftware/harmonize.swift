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
        productionCode.sources().filter { $0.fileName?.contains("Tests") == true }
            .assertEmpty()
        
        productionCode.classes().filter { $0.name.contains("Tests") }
            .assertEmpty()
    }
    
    func testAssertNotEmpty() throws {
       testCode.sources().assertNotEmpty()
        testCode.classes().assertNotEmpty()
    }
    
    func testAssertTrue() throws {
        testCode.sources().assertTrue { _ in
            true
        }
        
        testCode.classes().assertTrue { _ in
            true
        }
    }
    
    func testAssertFalse() throws {
        testCode.sources().assertFalse { _ in
            false
        }
        
        testCode.classes().assertFalse { _ in
            false
        }
    }
    
    func testAssertCount() throws {
        productionCode.sources().assertCount(count: 2)
        productionCode.classes().assertCount(count: 3)
    }
}
