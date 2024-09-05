//
//  HarmonizeTests.swift
//  
//
//  Created by Lucas Cavalcante on 8/29/24.
//
import Foundation
import Harmonize
import XCTest

final class HarmonizeTests: XCTestCase {
    private var harmonize: Harmonize {
        HarmonizeUtils().appendingPath("Fixtures/AnyDeclaration").harmonize()
    }
    
    func testAssertCanParseAllDeclarationsIncludingNested() throws {
        let declarations = harmonize.declarations()
        XCTAssertEqual(declarations.count, 15)
    }
    
    func testAssertCanParseTopLevelDeclarationsOnly() throws {
        let declarations = harmonize.declarations(includeNested: false)
        XCTAssertEqual(declarations.count, 5)
    }
}

