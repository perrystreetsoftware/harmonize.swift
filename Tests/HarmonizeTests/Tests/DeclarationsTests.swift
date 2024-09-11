//
//  DeclarationsTests.swift
//  
//
//  Created by Lucas Cavalcante on 8/29/24.
//
import Foundation
import Harmonize
import XCTest

final class DeclarationsTests: XCTestCase {
    private var harmonize = TestUtils.harmonize(at: "Fixtures/AnyDeclaration")

    func testAssertCanParseAllDeclarationsIncludingNested() throws {
        let declarations = harmonize.declarations(includeNested: true)
        XCTAssertEqual(declarations.count, 15)
    }
    
    func testAssertCanParseTopLevelDeclarationsOnly() throws {
        let declarations = harmonize.declarations(includeNested: false)
        XCTAssertEqual(declarations.count, 5)
    }
}
