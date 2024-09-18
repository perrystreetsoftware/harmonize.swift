//
//  AssertionsFailures.swift
//
//
//  Created by Lucas Cavalcante on 9/13/24.
//

import Foundation
import XCTest
import Harmonize

final class AssertionsFailuresTests: XCTestCase {
    override var testRunClass: AnyClass? {
        return Self.ExpectedFailureTestCaseRun.self
    }
    
    private let testCode = Harmonize.testCode().on("SampleApp")
    private let productionCode = Harmonize.productionCode().on("SampleApp")
    
    func testAssertEmptyFailure() throws {
        testCode.files().assertEmpty()
    }
    
    func testAssertNotEmptyFailure() throws {
        productionCode.files().filter { $0.fileName.contains("Tests") }.assertNotEmpty()
    }
    
    func testAssertTrueFailure() throws {
        testCode.files().assertTrue { !$0.fileName.hasSuffix("Tests") }
    }
    
    func testAssertFalseFailure() throws {
       testCode.files().assertFalse { $0.fileName.hasSuffix("Tests") }
    }
    
    func testAssertCountFailure() throws {
        productionCode.files().assertCount(count: 3)
    }
}

fileprivate extension AssertionsFailuresTests {
    /// Adapted from original source:
    /// https://medium.com/@matthew_healy/cuteasserts-dev-blog-1-wait-how-do-you-test-that-a-test-failed-37419eb33b49
    final class ExpectedFailureTestCaseRun: XCTestCaseRun {
        private var failed = false
        
        override func record(_ issue: XCTIssue) {
            failed = true
        }
        
        override func stop() {
            defer {
                failed = false
                super.stop()
            }
            
            guard failed else {
                super.record(.init(type: .assertionFailure, compactDescription: "Expected to fail but assertion passed."))
                return
            }
        }
    }
}
