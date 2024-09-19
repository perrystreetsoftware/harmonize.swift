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
    let productionCode = Harmonize.productionCode().on("SampleApp")
    let testCode = Harmonize.testCode().on("SampleApp")
    
    func testAssertEmpty() throws {
        productionCode.files().filter { $0.fileName.contains("Tests") }.assertEmpty()
    }
    
    func testAssertNotEmpty() throws {
       testCode.files().assertNotEmpty()
    }
    
    func testAssertTrue() throws {
        testCode.files().assertTrue { _ in
            true
        }
    }
    
    func testAssertFalse() throws {
        testCode.files().assertFalse { _ in
            false
        }
    }
    
    func testAssertCount() throws {
        productionCode.files().assertCount(count: 2)
    }
}
