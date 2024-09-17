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
    
    func testAssertEmptyFailure() throws {
        Harmonize.testCode().on("Tests")
            .files()
            .assertEmpty()
    }
    
    func testAssertNotEmptyFailure() throws {
        Harmonize.productionCode().on("Tests")
            .files()
            .assertNotEmpty()
    }
    
    func testAssertTrueFailure() throws {
        Harmonize.testCode().on("Tests")
            .files()
            .assertTrue { !$0.fileName.hasSuffix("Tests") }
    }
    
    func testAssertFalseFailure() throws {
        Harmonize.testCode().on("Tests")
            .files()
            .assertFalse { $0.fileName.hasSuffix("Tests") }
    }
    
    func testAssertCountFailure() throws {
        Harmonize.productionCode().on("Fixtures/SampleApp")
            .files()
            .assertCount(count: 3)
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
