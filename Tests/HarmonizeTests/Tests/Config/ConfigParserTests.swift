//
//  ConfigParserTests.swift
//  
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation
import XCTest
import Harmonize

final class ConfigParserTests: XCTestCase {
    func testAssertCanParseConfig() throws {
        let source = """
        excludes:
          - Tests
        """
        
        XCTAssertEqual(
            try Config(source),
            Config(excludePaths: ["Tests"])
        )
    }
    
    func testAssertCanParseConfigIfSourceIsEmpty() throws {
        let source = """
        """
        
        XCTAssertEqual(
            try Config(source),
            Config(excludePaths: [])
        )
    }
}
